# encoding: utf-8

require 'phonetic/algorithm'

module Phonetic
  # The Double Metaphone phonetic encoding algorithm is the second generation
  # of the Metaphone algorithm. Its original implementation was described
  # by Lawrence Philips in the June 2000 issue of C/C++ Users Journal.
  #
  # This implementation based on the PHP implementation by Stephen Woodbridge
  # and contains modifications of algorithm by Kevin Atkinson.
  # @see http://swoodbridge.com/DoubleMetaPhone/
  #      PHP implementation by Stephen Woodbridge
  # @see http://aspell.net/metaphone/dmetaph.cpp
  #      C++ implementation with modifications by Kevin Atkinson
  # @example
  #    Phonetic::DoubleMetaphone.encode('czerny') # => ['SRN', 'XRN']
  #    Phonetic::DoubleMetaphone.encode('dumb')   # => ['TM', 'TM']
  #    Phonetic::DoubleMetaphone.encode('edgar')  # => ['ATKR', 'ATKR']
  #    # or use alias:
  #    Phonetic::Metaphone2.encode('czerny') # => ['SRN', 'XRN']
  #    Phonetic::Metaphone2.encode('dumb')   # => ['TM', 'TM']
  #    Phonetic::Metaphone2.encode('edgar')  # => ['ATKR', 'ATKR']
  class DoubleMetaphone < Algorithm
    VOWELS = 'AEIOUY'

    # Encode word to its Double Metaphone code.
    def self.encode_word(word, options = { size: 4 })
      code_size = options[:size] || 4
      w = word.strip.upcase
      code = ['', '']
      def code.add(primary, secondary)
        self[0] += primary
        self[1] += secondary
      end
      i = 0
      len = w.size
      last = len - 1
      # pad the original string so that we can index beyond the edge of the world
      w += ' ' * 5
      # skip these when at start of word
      i += 1 if w[0, 2] =~ /[GKP]N|WR|PS/
      # initial 'X' is pronounced 'Z' e.g. 'Xavier'
      if w[0] == 'X'
        code.add 'S', 'S'
        i += 1
      end
      while i < len && (code.first.size < code_size || code.last.size < code_size)
        case w[i]
        when 'A', 'E', 'I', 'O', 'U', 'Y'
          code.add 'A', 'A' if i == 0 # all init vowels now map to 'A'
          i += 1
        when 'B'
          # "-mb", e.g", "dumb", already skipped over...
          code.add 'P', 'P'
          i += w[i + 1] == 'B' ? 2 : 1
        when 'Ç', 'ç'
          code.add 'S', 'S'
          i += 1
        when 'C'
          # various germanic
          if c_germanic?(w, i)
            code.add 'K', 'K'
            i += 2
          # special case 'caesar'
          elsif i == 0 && w[i, 6] == 'CAESAR'
            code.add 'S', 'S'
            i += 2
          # italian 'chianti'
          elsif w[i, 4] == 'CHIA'
            code.add 'K', 'K'
            i += 2
          elsif w[i, 2] == 'CH'
            # find 'michael'
            if i > 0 && w[i, 4] == 'CHAE'
              code.add 'K', 'X'
            # greek roots e.g. 'chemistry', 'chorus'
            elsif ch_greek_roots?(w, i)
              code.add 'K', 'K'
            # germanic, greek, or otherwise 'ch' for 'kh' sound
            elsif ch_germanic_or_greek?(w, i, len)
              code.add 'K', 'K'
            elsif i == 0
              code.add 'X', 'X'
            elsif w[0, 2] == 'MC'
              # e.g., "McHugh"
              code.add 'K', 'K'
            else
              code.add 'X', 'K'
            end
            i += 2
          elsif w[i, 2] == 'CZ' && !(i > 1 && w[i - 2, 4] == 'WICZ')
            # e.g, 'czerny'
            code.add 'S', 'X'
            i += 2
          elsif w[i + 1, 3] == 'CIA'
            # e.g., 'focaccia'
            code.add 'X', 'X'
            i += 3
          # double 'C', but not if e.g. 'McClellan'
          elsif w[i, 2] == 'CC' && !(i == 1 && w[0] == 'M')
            # 'bellocchio' but not 'bacchus'
            if w[i + 2, 1] =~ /[IEH]/ && w[i + 2, 2] != 'HU'
              # 'accident', 'accede' 'succeed'
              if i == 1 && w[i - 1] == 'A' || w[i - 1, 5] =~ /UCCEE|UCCES/
                # 'bacci', 'bertucci', other italian
                code.add 'KS', 'KS'
              else
                code.add 'X', 'X'
              end
              i += 1
            else
              # Pierce's rule
              code.add 'K', 'K'
            end
            i += 2
          elsif w[i, 2] =~ /C[KGQ]/
            code.add 'K', 'K'
            i += 2
          elsif w[i, 2] =~ /C[IEY]/
            # italian vs. english
            if w[i, 3] =~ /CI[OEA]/
              code.add 'S', 'X'
            else
              code.add 'S', 'S'
            end
            i += 2
          else
            code.add 'K', 'K'
            # name sent in 'mac caffrey', 'mac gregor'
            if w[i + 1, 2] =~ /\s[CQG]/
              i += 3
            elsif w[i + 1] =~ /[CKQ]/ && !(w[i + 1, 2] =~ /C[EI]/)
              i += 2
            else
              i += 1
            end
          end
        when 'D'
          if w[i, 2] == 'DG'
            if w[i + 2] =~ /[IEY]/
              # e.g. 'edge'
              code.add 'J', 'J'
              i += 3
            else
              # e.g. 'edgar'
              code.add 'TK', 'TK'
              i += 2
            end
          elsif w[i, 2] =~ /D[TD]/
            code.add 'T', 'T'
            i += 2
          else
            code.add 'T', 'T'
            i += 1
          end
        when 'F', 'K', 'N'
          code.add w[i], w[i]
          if w[i + 1] == w[i]
            i += 2
          else
            i += 1
          end
        when 'G'
          if w[i + 1] == 'H'
            if i > 0 && !vowel?(w[i - 1])
              code.add 'K', 'K'
              i += 2
            elsif i == 0
              # ghislane, ghiradelli
              if w[i + 2] == 'I'
                code.add 'J', 'J'
              else
                code.add 'K', 'K'
              end
              i += 2
            # Parker's rule (with some further refinements) - e.g., 'hugh'
            elsif (i > 1 && w[i - 2] =~ /[BHD]/) ||
                  # e.g., 'bough'
                  (i > 2 && w[i - 3] =~ /[BHD]/) ||
                  # e.g., 'broughton'
                  (i > 3 && w[i - 4] =~ /[BH]/)
              i += 2
            else
              # e.g., 'laugh', 'McLaughlin', 'cough', 'gough', 'rough', 'tough'
              if i > 2 && w[i - 1] == 'U' && w[i - 3] =~ /[CGLRT]/
                code.add 'F', 'F'
              elsif i > 0 && w[i - 1] != 'I'
                code.add 'K', 'K'
              end
              i += 2
            end
          elsif w[i + 1] == 'N'
            if i == 1 && vowel?(w[0]) && !slavo_germanic?(w)
              code.add 'KN', 'N'
            else
              # not e.g. 'cagney'
              if w[i + 2, 2] != 'EY' && w[i + 1] != 'Y' && !slavo_germanic?(w)
                code.add 'N', 'KN'
              else
                code.add 'KN', 'KN'
              end
            end
            i += 2
          # 'tagliaro'
          elsif w[i + 1, 2] == 'LI' && !slavo_germanic?(w)
            code.add 'KL', 'L'
            i += 2
          # -ges-,-gep-,-gel-, -gie- at beginning
          elsif i == 0 && (w[i + 1] == 'Y' || w[i + 1, 2] =~ /E[SPBLY]|I[BLNE]|E[IR]/)
            code.add 'K', 'J'
            i += 2
          # -ger-,  -gy-
          elsif (w[i + 1, 2] == 'ER' || w[i + 1] == 'Y') &&
                !(w[0, 6] =~ /[DRM]ANGER/) &&
                !(i > 0 && w[i - 1] =~ /[EI]/) &&
                !(i > 0 && w[i - 1, 3] =~ /RGY|OGY/)
            code.add 'K', 'J'
            i += 2
          # italian e.g, 'biaggi'
          elsif w[i + 1] =~ /[EIY]/ || (i > 0 && w[i - 1, 4] =~ /[AO]GGI/)
            if w[0, 4] =~ /(VAN|VON)\s/ || w[0, 3] == 'SCH' || w[i + 1, 2] == 'ET'
              code.add 'K', 'K'
            else
              if w[i + 1, 4] =~ /IER\s/
                code.add 'J', 'J'
              else
                code.add 'J', 'K'
              end
            end
            i += 2
          else
            i += w[i + 1] == 'G' ? 2 : 1
            code.add 'K', 'K'
          end
        when 'H'
          # only keep if first & before vowel or btw. 2 vowels
          if (i == 0 || i > 0 && vowel?(w[i - 1])) && vowel?(w[i + 1])
            code.add 'H', 'H'
            i += 2
          else # also takes care of 'HH'
            i += 1
          end
        when 'J'
          # obvious spanish, 'jose', 'san jacinto'
          if w[i, 4] == 'JOSE' || w[0, 4] =~ /SAN\s/
            if i == 0 && w[i + 4] == ' ' || w[0, 4] =~ /SAN\s/
              code.add 'H', 'H'
            else
              code.add 'J', 'H'
            end
            i += 1
          else
            if i == 0 && w[i, 4] != 'JOSE'
              code.add 'J', 'A'
              # Yankelovich/Jankelowicz
            else
              # spanish pron. of e.g. 'bajador'
              if i > 0 && vowel?(w[i - 1]) && !slavo_germanic?(w) && (w[i + 1] == 'A' || w[i + 1] == 'O')
                code.add 'J', 'H'
              elsif i == last
                code.add 'J', ''
              elsif !(w[i + 1] =~ /[LTKSNMBZ]/) && !(i > 0 && w[i - 1] =~ /[SKL]/)
                code.add 'J', 'J'
              end
            end
            i += w[i + 1] == 'J' ? 2 : 1
          end
        when 'L'
          if w[i + 1] == 'L'
            # spanish e.g. 'cabrillo', 'gallegos'
            if l_spanish?(w, i, len)
              code.add 'L', ''
            else
              code.add 'L', 'L'
            end
            i += 2
          else
            code.add 'L', 'L'
            i += 1
          end
        when 'M'
          if (i > 0 && w[i - 1, 3] == 'UMB' && (i + 1 == last || w[i + 2, 2] == 'ER')) ||
            w[i + 1] == 'M' # 'dumb','thumb'
            i += 1
          end
          i += 1
          code.add 'M', 'M'
        when 'Ñ', 'ñ'
          i += 1
          code.add 'N', 'N'
        when 'P'
          if w[i + 1] == 'H'
            code.add 'F', 'F'
            i += 2
          else
            # also account for "campbell", "raspberry"
            i += w[i + 1] =~ /[PB]/ ? 2 : 1
            code.add 'P', 'P'
          end
        when 'Q'
          i += w[i + 1] == 'Q' ? 2 : 1
          code.add 'K', 'K'
        when 'R'
          # french e.g. 'rogier', but exclude 'hochmeier'
          if i == last && !slavo_germanic?(w) &&
             (i > 1 && w[i - 2, 2] == 'IE') &&
             !(i > 3 && w[i - 4, 2] =~ /M[EA]/)
            code.add '', 'R'
          else
            code.add 'R', 'R'
          end
          i += w[i + 1] == 'R' ? 2 : 1
        when 'S'
          # special cases 'island', 'isle', 'carlisle', 'carlysle'
          if i > 0 && w[i - 1, 3] =~ /[IY]SL/
            i += 1
          # special case 'sugar-'
          elsif i == 0 && w[i, 5] == 'SUGAR'
            code.add 'X', 'S'
            i += 1
          elsif w[i, 2] == 'SH'
            # germanic
            if w[i + 1, 4] =~ /H(EIM|OEK|OL[MZ])/
              code.add 'S', 'S'
            else
              code.add 'X', 'X'
            end
            i += 2
          # italian & armenian
          elsif w[i, 3] =~ /SI[OA]/
            if !slavo_germanic?(w)
              code.add 'S', 'X'
            else
              code.add 'S', 'S'
            end
            i += 3
          # german & anglicisations, e.g. 'smith' match 'schmidt', 'snider' match 'schneider'
          # also, -sz- in slavic language altho in hungarian it is pronounced 's'
          elsif i == 0 && w[i + 1] =~ /[MNLW]/ || w[i + 1] == 'Z'
            code.add 'S', 'X'
            i += w[i + 1] == 'Z' ? 2 : 1
          elsif w[i, 2] == 'SC'
            # Schlesinger's rule
            if w[i + 2] == 'H'
              # dutch origin, e.g. 'school', 'schooner'
              if w[i + 3, 2] =~ /OO|UY|E[DM]/
                code.add 'SK', 'SK'
              # 'schermerhorn', 'schenker'
              elsif w[i + 3, 2] =~ /E[RN]/
                code.add 'X', 'SK'
              elsif i == 0 && !vowel?(w[3]) && w[3] != 'W'
                code.add 'X', 'S'
              else
                code.add 'X', 'X'
              end
            elsif w[i + 2, 1] =~ /[IEY]/
              code.add 'S', 'S'
            else
              code.add 'SK', 'SK'
            end
            i += 3
          else
            # french e.g. 'resnais', 'artois'
            if i == last && i > 1 && w[i - 2, 2] =~ /[AO]I/
              code.add '', 'S'
            else
              code.add 'S', 'S'
            end
            i += 1 if w[i + 1] =~ /[SZ]/
            i += 1
          end
        when 'T'
          if w[i, 4] == 'TION'
            code.add 'X', 'X'
            i += 3
          elsif w[i, 3] =~ /TIA|TCH/
            code.add 'X', 'X'
            i += 3
          elsif w[i, 2] == 'TH' || w[i, 3] == 'TTH'
            # special case 'thomas', 'thames' or germanic
            if w[i + 2, 2] =~ /OM|AM/ || w[0, 4] =~ /VAN|VON\s/ || w[0, 3] == 'SCH'
              code.add 'T', 'T'
            else
              code.add '0', 'T'
            end
            i += 2
          else
            i += w[i + 1] =~ /[TD]/ ? 2 : 1
            code.add 'T', 'T'
          end
        when 'V'
          i += w[i + 1] == 'V' ? 2 : 1
          code.add 'F', 'F'
        when 'W'
          # can also be in middle of word
          if w[i, 2] == 'WR'
            code.add 'R', 'R'
            i += 2
          else
            if i == 0 && (vowel?(w[i + 1]) || w[i, 2] == 'WH')
              # Wasserman should match Vasserman
              if vowel?(w[i + 1])
                code.add 'A', 'F'
              else
                # need Uomo to match Womo
                code.add 'A', 'A'
              end
            end
            # Arnow should match Arnoff
            if i == last && i > 0 && vowel?(w[i - 1]) ||
               (i > 0 && w[i - 1, 5] =~ /EWSKI|EWSKY|OWSKI|OWSKY/) || w[0, 3] == 'SCH'
              code.add '', 'F'
            elsif w[i, 4] =~ /WICZ|WITZ/
              # polish e.g. 'filipowicz'
              code.add 'TS', 'FX'
              i += 3
            end
            i += 1
          end
        when 'X'
          # french e.g. breaux
          if !(i == last && (i > 2 && w[i - 3, 3] =~ /[IE]AU/ || i > 1 && w[i - 2, 2] =~ /[AO]U/))
            code.add 'KS', 'KS'
          end
          i += w[i + 1] =~ /[CX]/ ? 2 : 1
        when 'Z'
          # chinese pinyin e.g. 'zhao'
          if w[i + 1] == 'H'
            code.add 'J', 'J'
            i += 2
          else
            if w[i + 1, 2] =~ /ZO|ZI|ZA/ || slavo_germanic?(w) && (i > 0 && w[i - 1] != 'T')
              code.add 'S', 'TS';
            else
              code.add 'S', 'S';
            end
            i += w[i + 1] == 'Z' ? 2 : 1
          end
        else
          i += 1
        end
      end
      [code.first[0, code_size], code.last[0, code_size]]
    end

    def self.encode(str, options = { size: 4 })
      encode_word(str, options)
    end

    private

    def self.slavo_germanic?(str)
      !!(str[/W|K|CZ|WITZ/])
    end

    def self.vowel?(char)
      c = VOWELS[char.to_s]
      !c.nil? && !c.empty?
    end

    def self.c_germanic?(w, i)
      # various germanic
      i > 1 &&
      !vowel?(w[i - 2]) &&
      w[i - 1, 3] == 'ACH' &&
      w[i + 2] != 'I' &&
      (w[i + 2] != 'E' || w[i - 2, 6] =~ /[BM]ACHER/)
    end

    def self.ch_greek_roots?(w, i)
      # greek roots e.g. 'chemistry', 'chorus'
      i == 0 &&
      (w[i + 1, 5] =~ /HAR(AC|IS)/ || w[i + 1, 3] =~ /H(OR|YM|IA|EM)/) &&
      w[0, 5] != 'CHORE'
    end

    def self.ch_germanic_or_greek?(w, i, len)
      # germanic, greek, or otherwise 'ch' for 'kh' sound
      (w[0, 4] =~ /(V[AO]N)\s/ || w[0, 3] == 'SCH') ||
      # 'architect but not 'arch', 'orchestra', 'orchid'
      (i > 1 && w[i - 2, 6] =~ /ORCHES|ARCHIT|ORCHID/) ||
      (w[i + 2] =~ /[TS]/) ||
      (i > 0 && w[i - 1] =~ /[AOUE]/ || i == 0) &&
      # e.g., 'wachtler', 'wechsler', but not 'tichner'
      (w[i + 2] =~ /[LRNMBHFVW ]/ || i + 2 >= len)
    end

    def self.l_spanish?(w, i, len)
      last = len - 1
      # spanish e.g. 'cabrillo', 'gallegos'
      (i == len - 3 && i > 0 && w[i - 1, 4] =~ /ILL[OA]|ALLE/) ||
      (last > 0 && w[last - 1, 2] =~ /[AO]S/ || w[last] =~ /[AO]/) &&
      (i > 0 && w[i - 1, 4] == 'ALLE')
    end
  end
end

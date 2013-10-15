# encoding: utf-8

require 'phonetic/algorithm'

module Phonetic
  class DoubleMetaphone < Algorithm
    VOWELS = 'AEIOUY'

    def self.encode_word(word, options = { size: 4 })
      code_size = options[:size] || 4
      w = word.strip.upcase
      primary = ''
      secondary = ''
      i = 0
      len = w.size
      last = len - 1
      # pad the original string so that we can index beyond the edge of the world
      w += ' ' * 5
      # skip these when at start of word
      i += 1 if ['GN','KN','PN','WR','PS'].include? w[0, 2]
      # initial 'X' is pronounced 'Z' e.g. 'Xavier'
      if w[0] == 'X'
        primary += 'S'
        secondary += 'S'
        i += 1
      end
      while i < len && (primary.size < code_size || primary.size < code_size)
        case w[i]
        when 'A', 'E', 'I', 'O', 'U', 'Y'
          if i == 0
            # all init vowels now map to 'A'
            primary += 'A'
            secondary += 'A'
          end
          i += 1
        when 'B'
          # "-mb", e.g", "dumb", already skipped over...
          primary += 'P'
          secondary += 'P'
          i += (w[i + 1] == 'B') ? 2 : 1
        when 'Ç', 'ç'
          primary += 'S'
          secondary += 'S'
          i += 1
        when 'C'
          # various germanic
          if i > 1 && !vowel?(w[i - 2]) && w[i - 1, 3] == 'ACH' &&
             (w[i + 2] != 'I' && (w[i + 2] != 'E' || w[i - 2, 6] =~ /[BM]ACHER/))
            primary += 'K'
            secondary += 'K'
            i += 2
          # special case 'caesar'
          elsif i == 0 && w[i, 6] == 'CAESAR'
            primary += 'S'
            secondary += 'S'
            i += 2
          # italian 'chianti'
          elsif w[i, 4] == 'CHIA'
            primary += 'K'
            secondary += 'K'
            i += 2
          elsif w[i, 2] == 'CH'
            # find 'michael'
            if i > 0 && w[i, 4] == 'CHAE'
              primary += 'K'
              secondary += 'X'
              i += 2
            # greek roots e.g. 'chemistry', 'chorus'
            elsif i == 0 && (w[i + 1, 5] =~ /HARAC|HARIS/ || w[i + 1, 3] =~ /HOR|HYM|HIA|HEM/) &&
                  w[0, 5] != 'CHORE'
              primary += 'K'
              secondary += 'K'
              i += 2
            else
              # germanic, greek, or otherwise 'ch' for 'kh' sound
              if (w[0, 4] =~ /(VAN|VON)\s/ || w[0, 3] == 'SCH') ||
                 # 'architect but not 'arch', 'orchestra', 'orchid'
                 (i > 1 && w[i - 2, 6] =~ /ORCHES|ARCHIT|ORCHID/) ||
                 (w[i + 2] =~ /[TS]/) ||
                 ((i > 0 && w[i - 1] =~ /[AOUE]/) || i == 0) &&
                 # e.g., 'wachtler', 'wechsler', but not 'tichner'
                 (w[i + 2] =~ /[LRNMBHFVW ]/ || i + 2 >= len)
                primary += 'K'
                secondary += 'K'
              else
                if i > 0
                  if w[0, 2] == 'MC'
                    # e.g., "McHugh"
                    primary += 'K'
                    secondary += 'K'
                  else
                    primary += 'X'
                    secondary += 'K'
                  end
                else
                  primary += 'X'
                  secondary += 'X'
                end
              end
              i += 2
            end
          elsif w[i, 2] == 'CZ' && !(i > 1 && w[i - 2, 4] == 'WICZ')
            # e.g, 'czerny'
            primary += 'S'
            secondary += 'X'
            i += 2
          elsif w[i + 1, 3] == 'CIA'
            # e.g., 'focaccia'
            primary += 'X'
            secondary += 'X'
            i += 3
          # double 'C', but not if e.g. 'McClellan'
          elsif w[i, 2] == 'CC' && !(i == 1 && w[0] == 'M')
            # 'bellocchio' but not 'bacchus'
            if w[i + 2, 1] =~ /[IEH]/ && w[i + 2, 2] != 'HU'
              # 'accident', 'accede' 'succeed'
              if i == 1 && w[i - 1] == 'A' || w[i - 1, 5] =~ /UCCEE|UCCES/
                # 'bacci', 'bertucci', other italian
                primary += 'KS'
                secondary += 'KS'
              else
                primary += 'X'
                secondary += 'X'
              end
              i += 3
            else
              # Pierce's rule
              primary += 'K'
              secondary += 'K'
              i += 2
            end
          elsif w[i, 2] =~ /CK|CG|CQ/
            primary += 'K'
            secondary += 'K'
            i += 2
          elsif w[i, 2] =~ /CI|CE|CY/
            # italian vs. english
            if w[i, 3] =~ /CIO|CIE|CIA/
              primary += 'S'
              secondary += 'X'
            else
              primary += 'S'
              secondary += 'S'
            end
            i += 2
          else
            primary += 'K'
            secondary += 'K'
            # name sent in 'mac caffrey', 'mac gregor'
            if w[i + 1, 2] =~ /\s[CQG]/
              i += 3
            else
              if w[i + 1] =~ /[CKQ]/ && !(w[i + 1, 2] =~ /CE|CI/)
                i += 2
              else
                i += 1
              end
            end
          end
        when 'D'
          if w[i, 2] == 'DG'
            if w[i + 2] =~ /[IEY]/
              # e.g. 'edge'
              primary += 'J'
              secondary += 'J'
              i += 3
            else
              # e.g. 'edgar'
              primary += 'TK'
              secondary += 'TK'
              i += 2
            end
          elsif w[i, 2] =~ /DT|DD/
            primary += 'T'
            secondary += 'T'
            i += 2
          else
            primary += 'T'
            secondary += 'T'
            i += 1
          end
        when 'F'
          if w[i + 1] == 'F'
            i += 2
          else
            i += 1
          end
          primary += 'F'
          secondary += 'F'
        when 'G'
          if w[i + 1] == 'H'
            if i > 0 && !vowel?(w[i - 1])
              primary += 'K'
              secondary += 'K'
              i += 2
            elsif i == 0
              # ghislane, ghiradelli
              if w[i + 2] == 'I'
                primary += 'J'
                secondary += 'J'
              else
                primary += 'K'
                secondary += 'K'
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
                primary += 'F'
                secondary += 'F'
              else
                if i > 0 && w[i - 1] != 'I'
                  primary += 'K'
                  secondary += 'K'
                end
              end
              i += 2
            end
          elsif w[i + 1] == 'N'
            if i == 1 && vowel?(w[0]) && !slavo_germanic?(w)
              primary += 'KN'
              secondary += 'N'
            else
              # not e.g. 'cagney'
              if w[i + 2, 2] != 'EY' && w[i + 1] != 'Y' && !slavo_germanic?(w)
                primary += 'N'
                secondary += 'KN'
              else
                primary += 'KN'
                secondary += 'KN'
              end
            end
            i += 2
          # 'tagliaro'
          elsif w[i + 1, 2] == 'LI' && !slavo_germanic?(w)
            primary += 'KL'
            secondary += 'L'
            i += 2
          # -ges-,-gep-,-gel-, -gie- at beginning
          elsif i == 0 && (w[i + 1] == 'Y' || w[i + 1, 2] =~ /ES|EP|EB|EL|EY|IB|IL|IN|IE|EI|ER/)
            primary += 'K'
            secondary += 'J'
            i += 2
          # -ger-,  -gy-
          elsif (w[i + 1, 2] == 'ER' || w[i + 1] == 'Y') &&
                !(w[0, 6] =~ /[DRM]ANGER/) &&
                !(i > 0 && w[i - 1] =~ /[EI]/) &&
                !(i > 0 && w[i - 1, 3] =~ /RGY|OGY/)
            primary += 'K'
            secondary += 'J'
            i += 2
          # italian e.g, 'biaggi'
          elsif w[i + 1] =~ /[EIY]/ || (i > 0 && w[i - 1, 4] =~ /[AO]GGI/)
            if w[0, 4] =~ /(VAN|VON)\s/ || w[0, 3] == 'SCH' || w[i + 1, 2] == 'ET'
              primary += 'K'
              secondary += 'K'
            else
              if w[i + 1, 4] =~ /IER\s/
                primary += 'J'
                secondary += 'J'
              else
                primary += 'J'
                secondary += 'K'
              end
            end
            i += 2
          else
            if w[i + 1] == 'G'
              i += 2
            else
              i += 1
            end
            primary += 'K'
            secondary += 'K'
          end
        when 'H'
          # only keep if first & before vowel or btw. 2 vowels
          if (i == 0 || (i > 0 && vowel?(w[i - 1]))) && vowel?(w[i + 1])
            primary += 'H'
            secondary += 'H'
            i += 2
          else # also takes care of 'HH'
            i += 1
          end
        when 'J'
          # obvious spanish, 'jose', 'san jacinto'
          if w[i, 4] == 'JOSE' || w[0, 4] =~ /SAN\s/
            if i == 0 && w[i + 4] == ' ' || w[0, 4] =~ /SAN\s/
              primary += 'H'
              secondary += 'H'
            else
              primary += 'J'
              secondary += 'H'
            end
            i += 1
          else
            if i == 0 && w[i, 4] != 'JOSE'
              primary += 'J'
              secondary += 'A'
              # Yankelovich/Jankelowicz
            else
              # spanish pron. of e.g. 'bajador'
              if i > 0 && vowel?(w[i - 1]) && !slavo_germanic?(w) && (w[i + 1] == 'A' || w[i + 1] == 'O')
                primary += 'J'
                secondary += 'H'
              else
                if i == last
                  primary += 'J'
                  #secondary += ' '
                else
                  if !(w[i + 1] =~ /[LTKSNMBZ]/) && !(i > 0 && w[i - 1] =~ /[SKL]/)
                    primary += 'J'
                    secondary += 'J'
                  end
                end
              end
            end
            if w[i + 1] == 'J'
              i += 2
            else
              i += 1
            end
          end
        when 'K'
          if w[i + 1] == 'K'
            i += 2
          else
            i += 1
          end
          primary += 'K'
          secondary += 'K'
        when 'L'
          if w[i + 1] == 'L'
            # spanish e.g. 'cabrillo', 'gallegos'
            if (i == len - 3 && i > 0 && w[i - 1, 4] =~ /ILLO|ILLA|ALLE/) ||
               ((last > 0 && w[last - 1, 2] =~ /AS|OS/ || w[last] =~ /[AO]/) &&
               (i > 0 && w[i - 1, 4] == 'ALLE'))
              primary += 'L'
              i += 2
              next
            end
            i += 2
          else
            i += 1
          end
          primary += 'L'
          secondary += 'L'
        when 'M'
          if (i > 0 && w[i - 1, 3] == 'UMB' && (i + 1 == last || w[i + 2, 2] == "ER")) ||
             # 'dumb','thumb'
             w[i + 1] == 'M'
            i += 2
          else
            i += 1
          end
          primary += 'M'
          secondary += 'M'
        when 'N'
          if w[i + 1] == 'N'
            i += 2
          else
            i += 1
          end
          primary += 'N'
          secondary += 'N'
        when 'Ñ', 'ñ'
          i += 1;
          primary += 'N'
          secondary += 'N'
        when 'P'
          if w[i + 1] == 'H'
            primary += 'F'
            secondary += 'F'
            i += 2
          else
            # also account for "campbell", "raspberry"
            if w[i + 1] =~ /[PB]/
              i += 2
            else
              i += 1
            end
            primary += 'P'
            secondary += 'P'
          end
        when 'Q'
          if w[i + 1] == 'Q'
            i += 2
          else
            i += 1
          end
          primary += 'K'
          secondary += 'K'
        when 'R'
          # french e.g. 'rogier', but exclude 'hochmeier'
          if i == last && !slavo_germanic?(w) &&
             (i > 1 && w[i - 2, 2] == "IE") &&
             !(i > 3 && w[i - 4, 2] =~ /M[EA]/)
            secondary += 'R'
          else
            primary += 'R'
            secondary += 'R'
          end
          if w[i + 1] == 'R'
            i += 2
          else
            i += 1
          end
        when 'S'
          # special cases 'island', 'isle', 'carlisle', 'carlysle'
          if i > 0 && w[i - 1, 3] =~ /ISL|YSL/
            i += 1
          # special case 'sugar-'
          elsif i == 0 && w[i, 5] == 'SUGAR'
            primary += 'X'
            secondary += 'S'
            i += 1
          elsif w[i, 2] == 'SH'
            # germanic
            if w[i + 1, 4] =~ /HEIM|HOEK|HOLM|HOLZ/
              primary += 'S'
              secondary += 'S'
            else
              primary += 'X'
              secondary += 'X'
            end
            i += 2
          # italian & armenian
          elsif w[i, 3] =~ /SIO|SIA/ || w[i, 4] == 'SIAN'
            if !slavo_germanic?(w)
              primary += 'S'
              secondary += 'X'
            else
              primary += 'S'
              secondary += 'S'
            end
            i += 3
          # german & anglicisations, e.g. 'smith' match 'schmidt', 'snider' match 'schneider'
          # also, -sz- in slavic language altho in hungarian it is pronounced 's'
          elsif (i == 0 && w[i + 1] =~ /[MNLW]/) || w[i + 1] == 'Z'
            primary += 'S'
            secondary += 'X'
            if w[i + 1] == 'Z'
              i += 2
            else
              i += 1
            end
          elsif w[i, 2] == 'SC'
            # Schlesinger's rule
            if w[i + 2] == 'H'
              # dutch origin, e.g. 'school', 'schooner'
              if w[i + 3, 2] =~ /OO|ER|EN|UY|ED|EM/
                # 'schermerhorn', 'schenker'
                if w[i + 3, 2] =~ /ER|EN/
                  primary += 'X'
                  secondary += 'SK'
                else
                  primary += 'SK'
                  secondary += 'SK'
                end
                i += 3
              else
                if i == 0 && !vowel?(w[3]) && w[3] != 'W'
                  primary += 'X'
                  secondary += 'S'
                else
                  primary += 'X'
                  secondary += 'X'
                end
                i += 3
              end
            elsif w[i + 2, 1] =~ /[IEY]/
              primary += 'S'
              secondary += 'S'
              i += 3
            else
              primary += 'SK'
              secondary += 'SK'
              i += 3
            end
          else
            # french e.g. 'resnais', 'artois'
            if i == last && i > 1 && w[i - 2, 2] =~ /AI|OI/
              secondary += 'S'
            else
              primary += 'S'
              secondary += 'S'
            end
            if w[i + 1] =~ /[SZ]/
              i += 2
            else
              i += 1
            end
          end
        when 'T'
          if w[i, 4] == 'TION'
            primary += 'X'
            secondary += 'X'
            i += 3
          elsif w[i, 3] =~ /TIA|TCH/
            primary += 'X'
            secondary += 'X'
            i += 3
          elsif w[i, 2] == 'TH' || w[i, 3] == 'TTH'
            # special case 'thomas', 'thames' or germanic
            if w[i + 2, 2] =~ /OM|AM/ || w[0, 4] =~ /VAN|VON\s/ || w[0, 3] == 'SCH'
              primary += 'T'
              secondary += 'T'
            else
              primary += '0'
              secondary += 'T'
            end
            i += 2
          else
            if w[i + 1] =~ /[TD]/
              i += 2
            else
              i += 1
            end
            primary += 'T'
            secondary += 'T'
          end
        when 'V'
          if w[i + 1] == 'V'
            i += 2
          else
            i += 1
          end
          primary += 'F'
          secondary += 'F'
        when 'W'
          # can also be in middle of word
          if w[i, 2] == 'WR'
            primary += 'R'
            secondary += 'R'
            i += 2
          else
            if i == 0 && (vowel?(w[i + 1]) || w[i, 2] == 'WH')
              # Wasserman should match Vasserman
              if vowel?(w[i + 1])
                primary += 'A'
                secondary += 'F'
              else
                # need Uomo to match Womo
                primary += 'A'
                secondary += 'A'
              end
            end
            # Arnow should match Arnoff
            if i == last && i > 0 && vowel?(w[i - 1]) ||
               (i > 0 && w[i - 1, 5] =~ /EWSKI|EWSKY|OWSKI|OWSKY/) || w[0, 3] == 'SCH'
              secondary += 'F'
              i += 1
            elsif w[i, 4] =~ /WICZ|WITZ/
              # polish e.g. 'filipowicz'
              primary += 'TS'
              secondary += 'FX'
              i += 4
            else
              i += 1
            end
          end
        when 'X'
          # french e.g. breaux
          if !(i == last && ((i > 2 && w[i - 3, 3] =~ /IAU|EAU/) || (i > 1 && w[i - 2, 2] =~ /AU|OU/)))
            primary += 'KS'
            secondary += 'KS'
          end
          if w[i + 1] =~ /[CX]/
            i += 2
          else
            i += 1
          end
        when 'Z'
          # chinese pinyin e.g. 'zhao'
          if w[i + 1] == 'H'
            primary += 'J'
            secondary += 'J'
            i += 2
          else
            if w[i + 1, 2] =~ /ZO|ZI|ZA/ || slavo_germanic?(w) && (i > 0 && w[i - 1] != 'T')
              primary += 'S'
              secondary += 'TS';
            else
              primary += 'S'
              secondary += 'S';
            end
            if w[i + 1] == 'Z'
              i += 2
            else
              i += 1
            end
          end
        else
          i += 1
        end
      end
      [primary[0, code_size], secondary[0, code_size]]
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

  end
end

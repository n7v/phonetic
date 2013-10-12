require 'spec_helper'

describe Phonetic::Metaphone do
  describe '.encode' do
    it 'should drop duplicate adjacent letters, except for C' do
      Phonetic::Metaphone.encode('Accola Nikki Dillon').should == 'AKKL NK TLN'
    end

    it 'should drop the first letter if the word begins with KN, GN, PN, AE, WR' do
      Phonetic::Metaphone.encode('Knapp Gnome Phantom Aeneid Wright').should == 'NP NM FNTM ENT RT'
    end

    it 'should drop B if after M at the end of the word' do
      Phonetic::Metaphone.encode('Plumb Amber').should == 'PLM AMBR'
    end

    it 'should transform CIA to XIA' do
      Phonetic::Metaphone.encode('Ciara Phylicia').should == 'XR FLX'
    end

    it 'should transform CH to X if it is not the part of -SCH-' do
      Phonetic::Metaphone.encode('Dratch Heche Christina').should == 'TRX HX KRST'
    end

    it 'should transform -SCH- to -SKH-' do
      Phonetic::Metaphone.encode('School Deschanel').should == 'SKL TSKN'
    end

    it 'should transform C to S if followed by I, E, or Y. And to K otherwise' do
      Phonetic::Metaphone.encode('Felicity Joyce Nancy Carol C').should == 'FLST JS NNS KRL K'
    end

    it 'should transform D to J if followed by GE, GY, or GI. And to T otherwise' do
      Phonetic::Metaphone.encode('Coolidge Lodgy Dixie Pidgin D').should == 'KLJ LJ TKS PJN T'
    end

    it 'should drop G if followed by H and H is not at the end or before a vowel' do
      Phonetic::Metaphone.encode('Knight Clayburgh Haughton Monaghan').should == 'NT KLBR HTN MNKN'
    end

    it 'should transform G to J if before I, E, or Y, and to K other otherwise' do
      Phonetic::Metaphone.encode('Gigi Gena Peggy Gyllenhaal Madigan G').should == 'JJ JN PK JLNH MTKN K'
    end

    it 'should drop G if followed by N or NED and is at the end' do
      Phonetic::Metaphone.encode('GN GNE GNED Agnes Signed').should == 'N N NT ANS SNT'
    end

    it 'should drop H if after vowel and not before a vowel' do
      Phonetic::Metaphone.encode('Sarah Shahi Moorehead Poehler').should == 'SR XH MRHT PLR'
    end

    it 'should transform CK to K, PH to F, Q to K, V to F, Z to S' do
      Phonetic::Metaphone.encode('Acker Sophia Quinn Victoria Zelda Karen').should == 'AKR SF KN FKTR SLT KRN'
    end

    it 'should transform SH to XH, SIO to XIO, SIA to XIA' do
      Phonetic::Metaphone.encode('Ashley Siobhan Siamese').should == 'AXL XBHN XMS'
    end

    it 'should transform TIA to XIA, TIO to XIO, TH to 0, TCH to CH' do
      Phonetic::Metaphone.encode('Tia Portia Interaction Catherine Dratch Fletcher').should == 'X PRX INTR K0RN TRX FLXR'
    end

    it 'should transform WH to W at the beginning, drop W if not followed by a vowel' do
      Phonetic::Metaphone.encode('Whoopi Goodwin Harlow Hawley').should == 'WP KTWN HRL HL'
    end

    it 'should transform X to S at the beginning and X to KS otherwise' do
      Phonetic::Metaphone.encode('Xor Alexis X').should == 'SR ALKS S'
    end

    it 'should drop Y if not followed by a vowel' do
      Phonetic::Metaphone.encode('Yasmine Blonsky Blyth').should == 'YSMN BLNS BL0'
    end

    it 'should drop all vowels unless it is the beginning' do
      Phonetic::Metaphone.encode('Boardman Mary Ellen').should == 'BRTM MR ELN'
    end
  end
end

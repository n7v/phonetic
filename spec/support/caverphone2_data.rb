module Phonetic
  # Examples are taken from Caversham Project's paper
  # http://caversham.otago.ac.nz/files/working/ctp150804.pdf
  CAVERPHONE2_TEST_TABLE = {
    'STFNSN1111' => ['Stevenson'],
    'PTA1111111' => ['Peter'],
    'AT11111111' => [
      'add', 'aid', 'at', 'art', 'eat', 'earth', 'head', 'hit', 'hot',
      'hold', 'hard', 'heart', 'it', 'out', 'old'
    ],
    'RTA1111111' => ['rather', 'ready', 'writer'],
    'SSA1111111' => ['social'],
    'APA1111111' => ['able', 'appear'],
    'TTA1111111' => [
      'Darda', 'Datha', 'Dedie', 'Deedee', 'Deerdre', 'Deidre', 'Deirdre',
      'Detta', 'Didi', 'Didier', 'Dido', 'Dierdre', 'Dieter', 'Dita',
      'Ditter', 'Dodi', 'Dodie', 'Dody', 'Doherty', 'Dorthea', 'Dorthy',
      'Doti', 'Dotti', 'Dottie', 'Dotty', 'Doty', 'Doughty', 'Douty',
      'Dowdell', 'Duthie', 'Tada', 'Taddeo', 'Tadeo', 'Tadio', 'Tati',
      'Teador', 'Tedda', 'Tedder', 'Teddi', 'Teddie', 'Teddy', 'Tedi',
      'Tedie', 'Teeter', 'Teodoor', 'Teodor', 'Terti', 'Theda', 'Theodor',
      'Theodore', 'Theta', 'Thilda', 'Thordia', 'Tilda', 'Tildi', 'Tildie',
      'Tildy', 'Tita', 'Tito', 'Tjader', 'Toddie', 'Toddy', 'Torto', 'Tuddor',
      'Tudor', 'Turtle', 'Tuttle', 'Tutto'
    ],
    'KLN1111111' => [
      'Cailean', 'Calan', 'Calen', 'Callahan', 'Callan', 'Callean',
      'Carleen', 'Carlen', 'Carlene', 'Carlin', 'Carline', 'Carlyn',
      'Carlynn', 'Carlynne', 'Charlean', 'Charleen', 'Charlene',
      'Charline', 'Cherlyn', 'Chirlin', 'Clein', 'Cleon', 'Cline',
      'Cohleen', 'Colan', 'Coleen', 'Colene', 'Colin', 'Colleen',
      'Collen', 'Collin', 'Colline', 'Colon', 'Cullan', 'Cullen',
      'Cullin', 'Gaelan', 'Galan', 'Galen', 'Garlan', 'Garlen',
      'Gaulin', 'Gayleen', 'Gaylene', 'Giliane', 'Gillan', 'Gillian',
      'Glen', 'Glenn', 'Glyn', 'Glynn', 'Gollin', 'Gorlin', 'Kalin',
      'Karlan', 'Karleen', 'Karlen', 'Karlene', 'Karlin', 'Karlyn',
      'Kaylyn', 'Keelin', 'Kellen', 'Kellene', 'Kellyann', 'Kellyn',
      'Khalin', 'Kilan', 'Kilian', 'Killen', 'Killian', 'Killion',
      'Klein', 'Kleon', 'Kline', 'Koerlin', 'Kylen', 'Kylynn', 'Quillan',
      'Quillon', 'Qulllon', 'Xylon'
    ],
    'TN11111111' => [
      'Dan', 'Dane', 'Dann', 'Darn', 'Daune', 'Dawn', 'Ddene', 'Dean', 'Deane',
      'Deanne', 'DeeAnn', 'Deeann', 'Deeanne', 'Deeyn', 'Den', 'Dene', 'Denn',
      'Deonne', 'Diahann', 'Dian', 'Diane', 'Diann', 'Dianne', 'Diannne', 'Dine',
      'Dion', 'Dione', 'Dionne', 'Doane', 'Doehne', 'Don', 'Donn', 'Doone', 'Dorn',
      'Down', 'Downe', 'Duane', 'Dun', 'Dunn', 'Duyne', 'Dyan', 'Dyane', 'Dyann',
      'Dyanne', 'Dyun', 'Tan', 'Tann', 'Teahan', 'Ten', 'Tenn', 'Terhune', 'Thain',
      'Thaine', 'Thane', 'Thanh', 'Thayne', 'Theone', 'Thin', 'Thorn', 'Thorne',
      'Thun', 'Thynne', 'Tien', 'Tine', 'Tjon', 'Town', 'Towne', 'Turne', 'Tyne'
    ]
  }
end

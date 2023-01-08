Program Lab8ArrayOfString;
{
 Given a sequence of 2 to 50 words, each with 1 to 8 lowercase letters.
 Between adjacent words a comma or at least one space, after the last word a dot.
 Output words that are different from the last word, the word starts with a vowel and ends with a consonant
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

Const
  Vowels = 'aeiouy';
  Consonants = 'bcdfghjklmnpqrstvwxz';
  MaxLetters = 8;
  MinLetters = 1;
  MaxWords = 50;
  MinWords = 2;
  //Vowels - vowel letters
  //Consonants - consonant letters
  //MaxLetters - maximum amount of letters in a word
  //MinLetters - minimum amount of letters in a word
  //MaxWords - maximum amount of words in a sequence
  //MinWords - minimum amount of words in a sequence

Var
  InitialStr: string;
  Words: array[1..MaxWords] of string;
  i, WordCount, LetterCount: integer;
  isCorrect : boolean;
  //InitialStr - initial string
  //Words - words in sequence
  //i - cycle counter
  //WordCount - word count
  //LetterCount - letter count
  //isCorrect - flag to confirm the correctness of entering numbers

Begin

  Writeln('Enter a sequence. Words should be from 2 to 50, each with 1 to 8 lowercase letters.');
  Writeln('A virgule or at least one space between words. There should be a dot at the end.');
  Writeln('Output words that are different from the last word, the word starts with a vowel and ends with a consonant');

  //Cycle with postcondition for entering correct data
  repeat

    //Initialize the flag
    isCorrect:= True;

    Readln(InitialStr);

    //The sequence must end with a dot
    if InitialStr[High(InitialStr)] <> '.' then
    begin
      Writeln('Should be a dot at the end');
      isCorrect:= False;
    end
    else
    begin

      //Reset counter
      WordCount:= 0;

      //Checking and processing the sequence
      i:= Low(InitialStr);
      while (i < High(InitialStr)) and isCorrect do
      begin

        //Ñheck the words separately.
        LetterCount:= 0;
        while (InitialStr[i] <> ',') and (InitialStr[i] <> ' ') and (InitialStr[i] <> '.') and isCorrect do
        begin

          //Ñhecking for valid symbols
          if not (InitialStr[i] in ['a'..'z']) then
          begin
            Writeln('Found Invalid character! Enter the sequence again');
            isCorrect:= False;
          end;

          //Increasing the amount of letters
          Inc(LetterCount);

          //Modernize i
          Inc(i);
        end;

        //Increasing the amount of words
        Inc(WordCount);

        //Validity check of the amount of letters
        if not (LetterCount in [MinLetters..MaxLetters]) and isCorrect then
        begin
          Writeln('The word must be from ',MinLetters,' to ',MaxLetters,' letters');
          isCorrect:= False;
        end

        //If the amount of words is valid, write to the array of words
        else if WordCount <= MaxWords then
          Words[WordCount]:= Copy(InitialStr, i - LetterCount, LetterCount)
        else
        begin
          Writeln('The sequence must contain from ',MinWords,' to ',MaxWords,' words');
          isCorrect:= False;
        end;

        //Ignoring spaces
        if InitialStr[i] = ' ' then
          while InitialStr[i+1] = ' ' do
            Inc(i);

        Inc(i);
      end;

      //Validity check of the amount of words
      if (WordCount < MinWords) and isCorrect then
      begin
        Writeln('The sequence must contain from ',MinWords,' to ',MaxWords,' words');
        isCorrect:= False;
      end;

    end;

  until isCorrect;

  Writeln('Words satisfying the requirement:');

  //Iterate over all words except the last one
  for i := Low(Words) to WordCount-1 do
    if (Pos(Words[i, Low(Words[i])], Vowels) <> 0) and (Pos(Words[i, High(Words[i])], Consonants) <> 0)
        and (Words[i] <> Words[WordCount]) then
      Write(Words[i],' ');

  Readln;
End.

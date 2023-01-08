# Lab №8. String
---
### Task:
![The task](https://i.imgur.com/aMp2AGv.png)

## There are 2 variants:
### 1) Processed string 
[ ⠀⠀  Check scheme](#algorithm-scheme-the-first-variant-by-nassi-schneiderman-method)
[ ⠀⠀  Check code](#code-using-the-first-variant)
### 2) Array of string
[ ⠀⠀  Check code](#code-using-the-second-variant)

#### Language: Delphi

---

### Algorithm scheme the first variant (by Nassi-Schneiderman method): 

![Algorithm scheme](https://i.imgur.com/hpLOLcy.png)

### Code using the first variant:
``` pascal
Program Lab8ProcessedString;
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
  InitialStr, ProcessedStr, LastWord, CurrWord: string;
  FirstLastLetters: array[1..2] of char;
  i, j, WordCount, LetterCount, LengthWithoutLastWord: integer;
  isCorrect : boolean;
  //InitialStr - initial string
  //ProcessedStr - processed string
  //LastWord - last word in the sequence
  //CurrWord - current check word
  //FirstLastLetters - the first and last letter in the current check word
  //i, j - cycle counter
  //WordCount - word count
  //LetterCount - letter count
  //LengthWithoutLastWord - sequence length without last word
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

    //Сopy the initial string into a processed string
    ProcessedStr:= Copy(InitialStr, Low(InitialStr), Length(InitialStr));

    //The sequence must end with a dot
    if ProcessedStr[High(ProcessedStr)] <> '.' then
    begin
      Writeln('Should be a dot at the end');
      isCorrect:= False;
    end
    else
    begin

      //Reset counter
      WordCount:= 0;

      //Checking and processing the sequence
      i:= Low(ProcessedStr);
      while (i < High(ProcessedStr)) and isCorrect do
      begin

        //Сheck the words separately.
        LetterCount:= 0;
        while (ProcessedStr[i] <> ',') and (ProcessedStr[i] <> ' ') and (ProcessedStr[i] <> '.') and isCorrect do
        begin

          //Сhecking for valid symbols
          if not (ProcessedStr[i] in ['a'..'z']) then
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

        //Removing unnecessary symbols: punctuation marks and extra spaces
        else
          case ProcessedStr[i] of

            ',':
            begin
              Delete(ProcessedStr, i, 1);
              Insert(' ', ProcessedStr, i);
            end;

            ' ':
            begin

              j:= i;
              while not (ProcessedStr[j+1] in ['a'..'z']) do
                Inc(j);

              if j <> i then
                Delete(ProcessedStr, i+1, j-i);

            end;

            '.': Delete(ProcessedStr, i, 1);

          end;

        Inc(i);
      end;

      //Validity check of the amount of words
      if not (WordCount in [MinWords..MaxWords]) and isCorrect then
      begin
        Writeln('The sequence must contain from ',MinWords,' to ',MaxWords,' words');
        isCorrect:= False;
      end;

    end;

  until isCorrect;

  //Finding the last word
  LastWord:= Copy(ProcessedStr, High(ProcessedStr) - LetterCount + 1, LetterCount);

  Writeln('Words satisfying the requirement:');

  //Checking words (except the last one)
  j:= Low(ProcessedStr);
  LengthWithoutLastWord:= Length(ProcessedStr) - Length(LastWord);
  while j < LengthWithoutLastWord do
  begin

    //Find the first letter
    i:= j;
    FirstLastLetters[1]:= ProcessedStr[i];

    //Find the last letter
    while ProcessedStr[j+1] <> ' ' do
      Inc(j);
    FirstLastLetters[2]:= ProcessedStr[j];

    //Find the current word
    CurrWord:= Copy(ProcessedStr, i, j-i+1);

    //Condition check: first letter is a vowel, second is a consonant, not equal to the last word
    if (Pos(FirstLastLetters[1], Vowels) <> 0) and (Pos(FirstLastLetters[2], Consonants) <> 0) and (CurrWord <> LastWord) then
      Write(CurrWord,' ');

    //Modernize j
    Inc(j, 2);
  end;

  Readln;
End.
```

---

### Code using the second variant:
``` pascal
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

        //Сheck the words separately.
        LetterCount:= 0;
        while (InitialStr[i] <> ',') and (InitialStr[i] <> ' ') and (InitialStr[i] <> '.') and isCorrect do
        begin

          //Сhecking for valid symbols
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
```

// Maybe not the simplest, but a nice middle of the road reference implementation of FizzBuzz
// https://github.com/jimmckeeth/FizzBuzzEnterpriseEdition-Delphi/
program FizzBuzz;

{$APPTYPE CONSOLE}

uses
  SysUtils;

procedure RunFizzBuzz;
var
  i: Integer;
begin
  for i := 1 to 100 do
  begin
    if (i mod 3 = 0) and (i mod 5 = 0) then
      WriteLn('FizzBuzz')
    else if i mod 3 = 0 then
      WriteLn('Fizz')
    else if i mod 5 = 0 then
      WriteLn('Buzz')
    else
      WriteLn(i);
  end;
end;

begin
  try
    RunFizzBuzz;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;
end.

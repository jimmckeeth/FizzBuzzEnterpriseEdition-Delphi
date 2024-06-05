// Slightly overengineered implementation of FizzBuzz
// https://github.com/jimmckeeth/FizzBuzzEnterpriseEdition-Delphi/
program FizzBuzzEnterpriseEdition;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Generics.Collections;

type
  IFizzBuzzRule = interface
    ['{A89E1C4D-6475-4A93-8904-233B5F2EAC2C}']
    function ApplyRule(Number: Integer): string;
  end;

  TFizzRule = class(TInterfacedObject, IFizzBuzzRule)
  public
    function ApplyRule(Number: Integer): string;
  end;

  TBuzzRule = class(TInterfacedObject, IFizzBuzzRule)
  public
    function ApplyRule(Number: Integer): string;
  end;

  TFizzBuzzRule = class(TInterfacedObject, IFizzBuzzRule)
  public
    function ApplyRule(Number: Integer): string;
  end;

  TDefaultRule = class(TInterfacedObject, IFizzBuzzRule)
  public
    function ApplyRule(Number: Integer): string;
  end;

  TFizzBuzzProcessor = class
  private
    FRules: TList<IFizzBuzzRule>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRule(Rule: IFizzBuzzRule);
    procedure Process(Number: Integer);
  end;

{ TFizzRule }

function TFizzRule.ApplyRule(Number: Integer): string;
begin
  if Number mod 3 = 0 then
    Result := 'Fizz'
  else
    Result := '';
end;

{ TBuzzRule }

function TBuzzRule.ApplyRule(Number: Integer): string;
begin
  if Number mod 5 = 0 then
    Result := 'Buzz'
  else
    Result := '';
end;

{ TFizzBuzzRule }

function TFizzBuzzRule.ApplyRule(Number: Integer): string;
begin
  if (Number mod 3 = 0) and (Number mod 5 = 0) then
    Result := 'FizzBuzz'
  else
    Result := '';
end;

{ TDefaultRule }

function TDefaultRule.ApplyRule(Number: Integer): string;
begin
  Result := IntToStr(Number);
end;

{ TFizzBuzzProcessor }

constructor TFizzBuzzProcessor.Create;
begin
  FRules := TList<IFizzBuzzRule>.Create;
end;

destructor TFizzBuzzProcessor.Destroy;
begin
  FRules.Free;
  inherited;
end;

procedure TFizzBuzzProcessor.AddRule(Rule: IFizzBuzzRule);
begin
  FRules.Add(Rule);
end;

procedure TFizzBuzzProcessor.Process(Number: Integer);
var
  Rule: IFizzBuzzRule;
  Output: string;
begin
  Output := '';
  for Rule in FRules do
  begin
    Output := Output + Rule.ApplyRule(Number);
  end;

  if Output = '' then
    Output := TDefaultRule.Create.ApplyRule(Number);

  WriteLn(Output);
end;

procedure RunFizzBuzz;
var
  Processor: TFizzBuzzProcessor;
  I: Integer;
begin
  Processor := TFizzBuzzProcessor.Create;
  try
    Processor.AddRule(TFizzBuzzRule.Create);
    Processor.AddRule(TFizzRule.Create);
    Processor.AddRule(TBuzzRule.Create);

    for I := 1 to 100 do
    begin
      Processor.Process(I);
    end;
  finally
    Processor.Free;
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

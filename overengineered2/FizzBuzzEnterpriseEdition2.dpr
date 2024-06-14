// https://github.com/jimmckeeth/FizzBuzzEnterpriseEdition-Delphi/
program FizzBuzzEnterpriseEdition2;

{$APPTYPE CONSOLE}

uses
  SysUtils, Generics.Collections;

type
  // Interfaces
  IFizzBuzzRule = interface
    ['{A89E1C4D-6475-4A93-8904-233B5F2EAC2C}']
    function ApplyRule(Number: Integer): string;
  end;

  IFizzBuzzRuleFactory = interface
    ['{DFF5E1D4-1D14-44A1-ACB3-239B283AC7D9}']
    function CreateRule: IFizzBuzzRule;
  end;

  IFizzBuzzProcessor = interface
    ['{CD871ECD-2D47-4A17-ABBC-298A7150E759}']
    procedure AddRuleFactory(RuleFactory: IFizzBuzzRuleFactory);
    procedure Process(Number: Integer);
  end;

  // Rule Implementations
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

  // Rule Factory Implementations
  TFizzRuleFactory = class(TInterfacedObject, IFizzBuzzRuleFactory)
  public
    function CreateRule: IFizzBuzzRule;
  end;

  TBuzzRuleFactory = class(TInterfacedObject, IFizzBuzzRuleFactory)
  public
    function CreateRule: IFizzBuzzRule;
  end;

  TFizzBuzzRuleFactory = class(TInterfacedObject, IFizzBuzzRuleFactory)
  public
    function CreateRule: IFizzBuzzRule;
  end;

  TDefaultRuleFactory = class(TInterfacedObject, IFizzBuzzRuleFactory)
  public
    function CreateRule: IFizzBuzzRule;
  end;

  // FizzBuzz Processor
  TFizzBuzzProcessorImpl = class(TInterfacedObject, IFizzBuzzProcessor)
  private
    FRuleFactories: TList<IFizzBuzzRuleFactory>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRuleFactory(RuleFactory: IFizzBuzzRuleFactory);
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

{ TFizzRuleFactory }

function TFizzRuleFactory.CreateRule: IFizzBuzzRule;
begin
  Result := TFizzRule.Create;
end;

{ TBuzzRuleFactory }

function TBuzzRuleFactory.CreateRule: IFizzBuzzRule;
begin
  Result := TBuzzRule.Create;
end;

{ TFizzBuzzRuleFactory }

function TFizzBuzzRuleFactory.CreateRule: IFizzBuzzRule;
begin
  Result := TFizzBuzzRule.Create;
end;

{ TDefaultRuleFactory }

function TDefaultRuleFactory.CreateRule: IFizzBuzzRule;
begin
  Result := TDefaultRule.Create;
end;

{ TFizzBuzzProcessorImpl }

constructor TFizzBuzzProcessorImpl.Create;
begin
  FRuleFactories := TList<IFizzBuzzRuleFactory>.Create;
end;

destructor TFizzBuzzProcessorImpl.Destroy;
begin
  FRuleFactories.Free;
  inherited;
end;

procedure TFizzBuzzProcessorImpl.AddRuleFactory(RuleFactory: IFizzBuzzRuleFactory);
begin
  FRuleFactories.Add(RuleFactory);
end;

procedure TFizzBuzzProcessorImpl.Process(Number: Integer);
var
  RuleFactory: IFizzBuzzRuleFactory;
  Rule: IFizzBuzzRule;
  Output: string;
begin
  Output := '';
  for RuleFactory in FRuleFactories do
  begin
    Rule := RuleFactory.CreateRule;
    output := Rule.ApplyRule(Number);
    if output <> '' then break;
  end;

  if Output = '' then
  begin
    Rule := TDefaultRuleFactory.Create.CreateRule;
    Output := Rule.ApplyRule(Number);
  end;

  WriteLn(Output);
end;

procedure RunFizzBuzz;
var
  Processor: IFizzBuzzProcessor;
  I: Integer;
begin
  Processor := TFizzBuzzProcessorImpl.Create;
  Processor.AddRuleFactory(TFizzBuzzRuleFactory.Create);
  Processor.AddRuleFactory(TFizzRuleFactory.Create);
  Processor.AddRuleFactory(TBuzzRuleFactory.Create);

  for I := 1 to 100 do
  begin
    Processor.Process(I);
  end;
end;

begin
  try
    RunFizzBuzz;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;
  readln;
end.

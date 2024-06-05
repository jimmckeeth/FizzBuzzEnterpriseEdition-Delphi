// https://github.com/jimmckeeth/FizzBuzzEnterpriseEdition-Delphi/
program FizzBuzzEnterpriseEdition3;

{$APPTYPE CONSOLE}

uses
  SysUtils, Generics.Collections;

type
  // Interface for rules
  IFizzBuzzRule = interface
    ['{A89E1C4D-6475-4A93-8904-233B5F2EAC2C}']
    function ApplyRule(Number: Integer): string;
  end;

  // Interface for the rule factory
  IFizzBuzzRuleFactory = interface
    ['{DFF5E1D4-1D14-44A1-ACB3-239B283AC7D9}']
    function CreateRule: IFizzBuzzRule;
  end;

  // Interface for the processor
  IFizzBuzzProcessor = interface
    ['{CD871ECD-2D47-4A17-ABBC-298A7150E759}']
    procedure AddRuleFactory(RuleFactory: IFizzBuzzRuleFactory);
    procedure Process(Number: Integer);
  end;

  // Interface for the output handler
  IFizzBuzzOutput = interface
    ['{98F4E88D-888F-4D43-89B8-61E2CFAE8B3B}']
    procedure Write(Output: string);
  end;

  // Console output handler implementation
  TConsoleOutput = class(TInterfacedObject, IFizzBuzzOutput)
  public
    procedure Write(Output: string);
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

  // Processor Implementation
  TFizzBuzzProcessorImpl = class(TInterfacedObject, IFizzBuzzProcessor)
  private
    FRuleFactories: TList<IFizzBuzzRuleFactory>;
    FOutputHandler: IFizzBuzzOutput;
  public
    constructor Create(OutputHandler: IFizzBuzzOutput);
    destructor Destroy; override;
    procedure AddRuleFactory(RuleFactory: IFizzBuzzRuleFactory);
    procedure Process(Number: Integer);
  end;

{ TConsoleOutput }

procedure TConsoleOutput.Write(Output: string);
begin
  WriteLn(Output);
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

constructor TFizzBuzzProcessorImpl.Create(OutputHandler: IFizzBuzzOutput);
begin
  FRuleFactories := TList<IFizzBuzzRuleFactory>.Create;
  FOutputHandler := OutputHandler;
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
    Output := Output + Rule.ApplyRule(Number);
  end;

  if Output = '' then
  begin
    Rule := TDefaultRuleFactory.Create.CreateRule;
    Output := Rule.ApplyRule(Number);
  end;

  FOutputHandler.Write(Output);
end;

procedure RunFizzBuzz;
var
  Processor: IFizzBuzzProcessor;
  I: Integer;
  OutputHandler: IFizzBuzzOutput;
begin
  OutputHandler := TConsoleOutput.Create;
  Processor := TFizzBuzzProcessorImpl.Create(OutputHandler);
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
end.

unit DelphiAIDev.DB.Registers.Interfaces;

interface

uses
  System.SysUtils,
  DelphiAIDev.Types,
  DelphiAIDev.DB.Registers.Fields;

type
  IDelphiAIDevDatabasesModel = interface
    ['{3399A776-4B23-4CFC-8992-568AE07FE065}']
    function ReadGuid(const AGuid: string): TDelphiAIDevDBRegistersFields;
    procedure ReadData(AProc: TProc<TDelphiAIDevDBRegistersFields>; const AAutoFreeField: TAutoFreeField = TAutoFreeField.Yes);
    procedure SaveOrEditData(AFields: TDelphiAIDevDBRegistersFields);
    procedure RemoveData(const AGuid: string);
  end;

implementation

end.

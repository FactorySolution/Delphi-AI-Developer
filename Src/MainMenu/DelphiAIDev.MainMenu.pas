unit DelphiAIDev.MainMenu;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Menus,
  ToolsAPI,
  DelphiAIDev.Interfaces;

type
  TDelphiAIDevIDEMainMenu = class(TInterfacedObject, IDelphiAIDevIDEMainMenu)
  private
    FMainMenuIDE: TMainMenu;
    FMenuItemC4D: TMenuItem;
    constructor Create;
    procedure CreateMenuDelphiAIDeveloperInIDEMenu;
    function CreateSubMenu(AName: string; ACaption: string; AOnClick: TNotifyEvent; AImgIndex: Integer = -1; AShortCutStr: string = ''): TMenuItem;
    function GetShortCutStrChat: string;
  protected
    procedure CreateMenus;
  public
    class function GetInstance: IDelphiAIDevIDEMainMenu;
    destructor Destroy; override;
  end;

implementation

uses
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.IDE.ImageListMain,
  DelphiAIDev.MainMenu.Clicks;

var
  Instance: IDelphiAIDevIDEMainMenu;

class function TDelphiAIDevIDEMainMenu.GetInstance: IDelphiAIDevIDEMainMenu;
begin
  if not Assigned(Instance) then
    Instance := Self.Create;
  Result := Instance;
end;

constructor TDelphiAIDevIDEMainMenu.Create;
begin
  FMainMenuIDE := TUtilsOTA.GetINTAServices.MainMenu;
end;

destructor TDelphiAIDevIDEMainMenu.Destroy;
begin
  if Assigned(FMenuItemC4D) then
    FreeAndNil(FMenuItemC4D);
  inherited;
end;

procedure TDelphiAIDevIDEMainMenu.CreateMenus;
var
 LImgList: TDelphiAIDevIDEImageListMain;
begin
  LImgList := TDelphiAIDevIDEImageListMain.GetInstance;

  Self.CreateMenuDelphiAIDeveloperInIDEMenu;

  Self.CreateSubMenu(TConsts.MENU_IDE_CHAT_NAME,
    TConsts.MENU_IDE_CHAT_CAPTION,
    TDelphiAIDevIDEMainMenuClicks.ChatClick,
    LImgList.ImgIndexMessage,
    Self.GetShortCutStrChat);

  Self.CreateSubMenu(TConsts.PREFIX_NAME_SEPARATOR + '10', '-', nil);

  Self.CreateSubMenu(TConsts.MENU_IDE_DEFAULTS_QUESTIONS_NAME,
    TConsts.MENU_IDE_DEFAULTS_QUESTIONS_CAPTION,
    TDelphiAIDevIDEMainMenuClicks.DefaultsQuestionsClick,
    LImgList.ImgQuestion);

  Self.CreateSubMenu(TConsts.PREFIX_NAME_SEPARATOR + '20', '-', nil);

  Self.CreateSubMenu(TConsts.MENU_IDE_DEFAULTS_DATABASES_ADD_NAME,
    TConsts.MENU_IDE_DEFAULTS_DATABASES_ADD_Caption,
    TDelphiAIDevIDEMainMenuClicks.DatabasesAddClick,
    LImgList.ImgDatabaseAdd);

  Self.CreateSubMenu(TConsts.MENU_IDE_DEFAULTS_DATABASES_CHAT_NAME,
    TConsts.MENU_IDE_DEFAULTS_DATABASES_CHAT_CAPTION,
    TDelphiAIDevIDEMainMenuClicks.DatabasesChatClick,
    LImgList.ImgDatabaseExecute);

  Self.CreateSubMenu(TConsts.PREFIX_NAME_SEPARATOR + '30', '-', nil);

  Self.CreateSubMenu(TConsts.MENU_IDE_SETTINGS_NAME,
    TConsts.MENU_IDE_SETTINGS_CAPTION,
    TDelphiAIDevIDEMainMenuClicks.SettingsClick,
    LImgList.ImgIndexGear);

  Self.CreateSubMenu(TConsts.PREFIX_NAME_SEPARATOR + '40', '-', nil);
  Self.CreateSubMenu(TConsts.MENU_IDE_ABOUT_NAME,
    TConsts.MENU_IDE_ABOUT_CAPTION,
    TDelphiAIDevIDEMainMenuClicks.AboutClick,
    LImgList.ImgIndexC4D_Logo);
end;

procedure TDelphiAIDevIDEMainMenu.CreateMenuDelphiAIDeveloperInIDEMenu;
var
  LMenuItemTabs: TMenuItem;
  LMenuItemTools: TMenuItem;
begin
  FMenuItemC4D := TMenuItem(FMainMenuIDE.FindComponent(TConsts.ITEM_MENU_C4DDelphiAIDev_NAME));
  if Assigned(FMenuItemC4D) then
    FreeAndNil(FMenuItemC4D);

  FMenuItemC4D := TMenuItem.Create(FMainMenuIDE);
  FMenuItemC4D.Name := TConsts.ITEM_MENU_C4DDelphiAIDev_NAME;
  FMenuItemC4D.Caption := TConsts.ITEM_MENU_C4DDelphiAIDev_CAPTION;

  LMenuItemTabs := FMainMenuIDE.Items.Find('Tabs');
  if Assigned(LMenuItemTabs) then
  begin
    FMainMenuIDE.Items.Insert(FMainMenuIDE.Items.IndexOf(LMenuItemTabs), FMenuItemC4D);
    Exit;
  end;

  LMenuItemTools := FMainMenuIDE.Items.Find('Tools');
  if Assigned(LMenuItemTools) then
  begin
    FMainMenuIDE.Items.Insert(FMainMenuIDE.Items.IndexOf(LMenuItemTools) + 1, FMenuItemC4D);
    Exit;
  end;

  FMainMenuIDE.Items.Add(FMenuItemC4D);
end;

function TDelphiAIDevIDEMainMenu.CreateSubMenu(AName: string; ACaption: string; AOnClick: TNotifyEvent; AImgIndex: Integer = -1; AShortCutStr: string = ''): TMenuItem;
var
  LMenuItem: TMenuItem;
begin
  LMenuItem := TMenuItem.Create(FMenuItemC4D);
  LMenuItem.Name := AName;
  LMenuItem.Caption := ACaption;
  LMenuItem.OnClick := AOnClick;
  LMenuItem.ImageIndex := AImgIndex;
  LMenuItem.ShortCut := TextToShortCut(TUtils.RemoveSpacesAll(AShortCutStr));
  FMenuItemC4D.Add(LMenuItem);
  Result := LMenuItem;
end;

function TDelphiAIDevIDEMainMenu.GetShortCutStrChat: string;
begin
  Result := TConsts.SHORTCUT_CHAT_DEFAULT;
end;

initialization

finalization
  if Assigned(Instance) then
    Instance := nil;

end.

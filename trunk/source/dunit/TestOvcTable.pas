unit TestOvcTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OvcData,
  Dialogs, ovctcbef, ovctcpic, ovctcmmn, ovctcell, ovctcstr, ovctcedt, ovcbase, ovcef,
  StdCtrls,
  ovcsf, ovctable, TestFramework, ovctcnum, ovctcsim, ovctccustomedt, o32tcflx, ovctcbmp,
  ovctcgly, ovctcbox;

type
  TfrmTestOvcPictureField = class(TForm)
    OvcTable1: TOvcTable;
    OvcTCString1: TOvcTCString;
    OvcTCPictureField1: TOvcTCPictureField;
    OvcTCPictureField2: TOvcTCPictureField;
    OvcTCNumericField1: TOvcTCNumericField;
    OvcTCSimpleField1: TOvcTCSimpleField;
    OvcTable2: TOvcTable;
    OvcTCString1_SS: TOvcTCString;
    OvcTCMemo1: TOvcTCMemo;
    OvcTCMemo1_SS: TOvcTCMemo;
    O32TCFlexEdit1: TO32TCFlexEdit;
    O32TCFlexEdit1_SS: TO32TCFlexEdit;
    OvcTCCheckBox1: TOvcTCCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OvcTable1GetCellData(Sender: TObject; RowNum, ColNum: Integer; var Data: Pointer;
      Purpose: TOvcCellDataPurpose);
  private
    { Fields for storing the data being displayed in OvcTable1. To detect a possible
      "buffer-overflow" (that might occur when data is written back from the table)
      "Overflow"-fields are used. }
    Data_OvcTCString1: string;
    Data_Overflow_OvcTCString1: Integer;
    Data_OvcTCPictureField1: string;
    Data_Overflow_OvcTCPictureField1: Integer;
    Data_OvcTCPictureField2: Integer;
    Data_Overflow_OvcTCPictureField2: Integer;
    Data_OvcTCNumericField1: Double;
    Data_Overflow_OvcTCNumericField1: Integer;
    Data_OvcTCSimpleField1: string;
    Data_Overflow_OvcTCSimpleField1: Integer;
    Data_OvcTCMemo1: string;
    Data_Overflow_OvcTCMemo1: Integer;
    Data_O32TCFlexEdit1: string;
    Data_Overflow_O32TCFlexEdit1: Integer;
    { Fields for storing the data being displayed in OvcTable2. }
    Data_OvcTCString1_SS: string[10];
    Data_Overflow_OvcTCString1_SS: Integer;
    Data_OvcTCMemo1_SS: ShortString;
    Data_Overflow_OvcTCMemo1_SS: Integer;
    Data_O32TCFlexEdit1_SS: ShortString;
    Data_Overflow_O32TCFlexEdit1_SS: Integer;
    Data_OvcTCCheckBox1: StdCtrls.TCheckBoxState;
    Data_Overflow_OvcTCCheckBox1: Integer;
  end;

  TTestOvcTable = class(TTestCase)
  private
    FForm: TfrmTestOvcPictureField;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestOvcTCString;
    procedure TestOvcTCPictureField_pftString;
    procedure TestOvcTCPictureField_pftLongInt;
    procedure TestOvcTCNumericField_nftDouble;
    procedure TestOvcTCSimpleField_sftString;
    procedure TestOvcTCSimpleField_sftString_DataNIL;
    procedure TestOvcTCSimpleField_Passwordmode;
    procedure TestOvcTCMemo;
    procedure TestO32TCFlexEdit;
    procedure TestOvcTCString_SS;
    procedure TestOvcTCMemo_SS;
    procedure TestO32TCFlexEdit_SS;
    procedure TextOvcTCCheckBox_Click;
  end;

implementation

{$R *.dfm}


type
  TPOvcTCString = class(TOvcTCString);
  TPOvcTCPictureField = class(TOvcTCPictureField);
  TPOvcTCNumericField = class(TOvcTCNumericField);
  TPOvcTCSimpleField  = class(TOvcTCSimpleField);
  TPOvcBaseEntryField = class(TOvcBaseEntryField);
  TPOvcCustomSimpleField = class(TOvcCustomSimpleField);
  TPOvcTCMemo = class(TOvcTCMemo);
  TPO32TCFlexEdit = class(TO32TCFlexEdit);

procedure TfrmTestOvcPictureField.FormCreate(Sender: TObject);
begin
  Data_OvcTCString1                := '';
  Data_Overflow_OvcTCString1       := -1;
  Data_OvcTCPictureField1          := '';
  Data_Overflow_OvcTCPictureField1 := -1;
  Data_OvcTCPictureField2          :=  0;
  Data_Overflow_OvcTCPictureField2 := -1;
  Data_OvcTCNumericField1          :=  0;
  Data_Overflow_OvcTCNumericField1 := -1;
  Data_OvcTCSimpleField1           := '';
  Data_Overflow_OvcTCSimpleField1  := -1;
  Data_OvcTCMemo1                  := '';
  Data_Overflow_OvcTCMemo1         := -1;
  Data_O32TCFlexEdit1              := '';
  Data_Overflow_O32TCFlexEdit1     := -1;

  Data_OvcTCString1_SS             := '';
  Data_Overflow_OvcTCString1_SS    := -1;
  Data_OvcTCMemo1_SS               := '';
  Data_Overflow_OvcTCMemo1_SS      := -1;
  Data_O32TCFlexEdit1_SS           := '';
  Data_Overflow_O32TCFlexEdit1_SS  := -1;
  Data_OvcTCCheckBox1              := cbUnchecked;
  Data_Overflow_OvcTCCheckBox1     := -1;
end;

procedure TfrmTestOvcPictureField.OvcTable1GetCellData(Sender: TObject; RowNum, ColNum: Integer;
  var Data: Pointer; Purpose: TOvcCellDataPurpose);
begin
  if RowNum=0 then begin
    if Sender = OvcTable1 then begin
      case ColNum of
        0: data := @Data_OvcTCString1;
        1: data := @Data_OvcTCPictureField1;
        2: data := @Data_OvcTCPictureField2;
        3: data := @Data_OvcTCNumericField1;
        4: data := @Data_OvcTCSimpleField1;
        5: data := @Data_OvcTCMemo1;
        6: data := @Data_O32TCFlexEdit1;
        else
          data := nil;
      end;
    end else begin
      case ColNum of
        0: data := @Data_OvcTCString1_SS;
        1: data := @Data_OvcTCMemo1_SS;
        2: data := @Data_O32TCFlexEdit1_SS;
        3: data := @Data_OvcTCCheckBox1;
        else
          data := nil;
      end;
    end;
  end else
    { special case for 'TestOvcTCSimpleField_sftString_DataNIL' }
    data := nil;
end;

{ TTestOvcPictureField }

procedure TypeText(F:TPOvcBaseEntryField; const s:string); overload;
var
  i: Integer;
begin
  for i := 1 to Length(s) do begin
    Include(F.sefOptions, sefAcceptChar);
    Include(F.sefOptions, sefCharOK);
    F.Perform(WM_CHAR, Ord(s[i]), 0);
  end;
end;

procedure TypeText(E:TCustomEdit; const s:string); overload;
var
  i: Integer;
begin
  for i := 1 to Length(s) do begin
    E.Perform(WM_CHAR, Ord(s[i]), 0);
  end;
end;


procedure TTestOvcTable.TestOvcTCString;
  {- test OvcTCString }
begin
  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,0);
  FForm.OvcTable1.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCString(FForm.OvcTCString1).FEdit), 'another test');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals('another test', Trim(FForm.Data_OvcTCString1));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCString1, 'Data overflow for OvcTCString1');
end;


procedure TTestOvcTable.TestOvcTCPictureField_pftString;
  {- test OvcTCPictureField with datatype 'pftString' }
begin
  { Test reading data }
  FForm.Data_OvcTCPictureField1 := 'OvcTCField1';
  FForm.OvcTable1.Repaint;
  CheckEquals('OvcTCField1', Trim(TPOvcTCPictureField(FForm.OvcTCPictureField1).FEditDisplay.Text));

  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,1);
  FForm.OvcTable1.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCPictureField(FForm.OvcTCPictureField1).FEdit), 'another test');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals('another test', Trim(FForm.Data_OvcTCPictureField1));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCPictureField1, 'Data overflow for OvcTCPictureField1');
end;


procedure TTestOvcTable.TestOvcTCPictureField_pftLongInt;
  {- test OvcTCPictureField with datatype 'pftLongInt' }
begin
  { Test reading data }
  FForm.Data_OvcTCPictureField2 := 123456789;
  FForm.OvcTable1.Repaint;
  CheckEquals('123456789', Trim(TPOvcTCPictureField(FForm.OvcTCPictureField2).FEditDisplay.Text));

  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,2);
  FForm.OvcTable1.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCPictureField(FForm.OvcTCPictureField2).FEdit), '987654321');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals(987654321, FForm.Data_OvcTCPictureField2);
  CheckEquals(-1, FForm.Data_Overflow_OvcTCPictureField2, 'Data overflow for OvcTCPictureField2');
end;


procedure TTestOvcTable.TestOvcTCNumericField_nftDouble;
  {- test OvcTCNumericField with datatype 'nftDouble' }
begin
  { Test reading data }
  FForm.Data_OvcTCNumericField1 := 1234.56;
  FForm.OvcTable1.Repaint;
  CheckEquals('1.234,56', Trim(TPOvcTCNumericField(FForm.OvcTCNumericField1).FEditDisplay.Text));

  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,3);
  FForm.OvcTable1.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCNumericField(FForm.OvcTCNumericField1).FEdit), '6543,21');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals(Format('%.2n',[6543.21]), Format('%.2n',[FForm.Data_OvcTCNumericField1]));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCNumericField1, 'Data overflow for OvcTCNumericField1');
end;


procedure TTestOvcTable.TestOvcTCSimpleField_sftString;
  {- test OvcTCSimpleField with datatype 'sftString' }
begin
  { Test reading data }
  FForm.Data_OvcTCSimpleField1 := 'OvcTCSimpleField1';
  FForm.OvcTable1.Repaint;
  CheckEquals('OvcTCSimpleField1', Trim(TPOvcTCSimpleField(FForm.OvcTCSimpleField1).FEditDisplay.Text));

  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,4);
  FForm.OvcTable1.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCSimpleField(FForm.OvcTCSimpleField1).FEdit), 'sft field test');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals('sft field test', Trim(FForm.Data_OvcTCSimpleField1));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCSimpleField1, 'Data overflow for OvcTCSimpleField1');
end;


procedure TTestOvcTable.TestOvcTCSimpleField_sftString_DataNIL;
  {- test for a corner case that was handled incorrectly in rev 191}
var
  s: string;
begin
  FForm.Data_OvcTCSimpleField1 := 'Cell(0,4)';
  { Go to cell (0,4) and start editing state to make sure the content of the cell ('Cell(0,4)')
    is transfered to the underlying TOvcBaseEntryField. }
  FForm.OvcTable1.SetActiveCell(0,4);
  FForm.OvcTable1.StartEditingState;
  FForm.OvcTable1.StopEditingState(False);
  { go to the next line an start editing again; OvcTable1GetCellData will provide no data
    here; the ovctable must take care to clear the contents of the edit field in this case }
  FForm.OvcTable1.SetActiveCell(1,4);
  FForm.OvcTable1.StartEditingState;
  FForm.OvcTCSimpleField1.SaveEditedData(@s);
  CheckEqualsString('', s);
end;


procedure TTestOvcTable.TestOvcTCSimpleField_Passwordmode;
  {- test for a bug that was fixed in rev 201: TOvcTCSimpleField did not display
     Password-characters properly in unicode. }
var
  sf: TPOvcCustomSimpleField;
  dest: array[0..20] of Char;
begin
  FForm.Data_OvcTCSimpleField1 := 'password';
  try
    FForm.OvcTCSimpleField1.Options := FForm.OvcTCSimpleField1.Options + [efoPasswordmode];
    FForm.OvcTable1.Repaint;
    sf := TPOvcCustomSimpleField(TPOvcTCSimpleField(FForm.OvcTCSimpleField1).FEditDisplay);
    sf.efGetDisplayString(dest, High(dest));
    CheckEquals('********', dest);
  finally
    FForm.OvcTCSimpleField1.Options := FForm.OvcTCSimpleField1.Options - [efoPasswordmode];
  end;
end;


procedure TTestOvcTable.TestOvcTCMemo;
  {- test OvcTCMemo }
begin
  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,5);
  FForm.OvcTable1.StartEditingState;
  TypeText(TOvcTCMemoEdit(TPOvcTCMemo(FForm.OvcTCMemo1).FEdit), 'sft field test');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals('sft field test', Trim(FForm.Data_OvcTCMemo1));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCMemo1, 'Data overflow for OvcTCMemo1');
end;


procedure TTestOvcTable.TestO32TCFlexEdit;
  {- test O32TCFlexEdit }
begin
  { Test typing data }
  FForm.OvcTable1.SetFocus;
  FForm.OvcTable1.SetActiveCell(0,6);
  FForm.OvcTable1.StartEditingState;
  TypeText(TCustomEdit(TPO32TCFlexEdit(FForm.O32TCFlexEdit1).FEdit), 'FlexTest');
  FForm.OvcTable1.StopEditingState(True);
  CheckEquals('FlexTest', Trim(FForm.Data_O32TCFlexEdit1));
  CheckEquals(-1, FForm.Data_Overflow_O32TCFlexEdit1, 'Data overflow for O32TCFlexEdit1');
end;


procedure TTestOvcTable.TestOvcTCString_SS;
  {- test OvcTCString with ShortString for storing the data }
begin
  { Test typing data }
  FForm.OvcTable2.SetFocus;
  FForm.OvcTable2.SetActiveCell(0,0);
  FForm.OvcTable2.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCString(FForm.OvcTCString1_SS).FEdit), 'TEST1');
  FForm.OvcTable2.StopEditingState(True);
  CheckEquals('TEST1', Trim(string(FForm.Data_OvcTCString1_SS)));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCString1_SS, 'Data overflow for OvcTCString1_SS');
  { Test typing maximum number of characters }
  FForm.Data_OvcTCString1_SS := '';
  FForm.OvcTable2.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCString(FForm.OvcTCString1_SS).FEdit), '1234567890');
  FForm.OvcTable2.StopEditingState(True);
  CheckEquals('1234567890', Trim(string(FForm.Data_OvcTCString1_SS)));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCString1_SS, 'Data overflow for OvcTCString1_SS');
  { Test typing more than the maximum number of characters }
  FForm.Data_OvcTCString1_SS := '';
  FForm.OvcTable2.StartEditingState;
  TypeText(TPOvcBaseEntryField(TPOvcTCString(FForm.OvcTCString1_SS).FEdit), '1234567890X');
  FForm.OvcTable2.StopEditingState(True);
  CheckEquals('1234567890', Trim(string(FForm.Data_OvcTCString1_SS)));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCString1_SS, 'Data overflow for OvcTCString1_SS');
end;


procedure TTestOvcTable.TestOvcTCMemo_SS;
  {- test OvcTCMemo with ShortString for storing the data }
begin
  { Test typing data }
  FForm.OvcTable2.SetFocus;
  FForm.OvcTable2.SetActiveCell(0,1);
  FForm.OvcTable2.StartEditingState;
  TypeText(TOvcTCMemoEdit(TPOvcTCMemo(FForm.OvcTCMemo1_SS).FEdit), 'sft field test'#13'line 2');
  FForm.OvcTable2.StopEditingState(True);
  CheckEquals('sft field test'#13#10'line 2', Trim(string(FForm.Data_OvcTCMemo1_SS)));
  CheckEquals(-1, FForm.Data_Overflow_OvcTCMemo1_SS, 'Data overflow for OvcTCMemo1_SS');
end;


procedure TTestOvcTable.TestO32TCFlexEdit_SS;
  {- test O32TCFlexEdit with ShortString for storing the data }
begin
  { Test typing data }
  FForm.OvcTable2.SetFocus;
  FForm.OvcTable2.SetActiveCell(0,2);
  FForm.OvcTable2.StartEditingState;
  TypeText(TCustomEdit(TPO32TCFlexEdit(FForm.O32TCFlexEdit1_SS).FEdit), 'FlexTest');
  FForm.OvcTable2.StopEditingState(True);
  CheckEquals('FlexTest', Trim(string(FForm.Data_O32TCFlexEdit1_SS)));
  CheckEquals(-1, FForm.Data_Overflow_O32TCFlexEdit1_SS, 'Data overflow for O32TCFlexEdit1_SS');
end;


procedure TTestOvcTable.TextOvcTCCheckBox_Click;
  {- test for a Bug fixed in rev 213: In a table with otoNoSelection in Options it took
     three clicks on a cell containing a checkBox to change the checkbox' state. }
begin
  FForm.Data_OvcTCCheckBox1 := cbUnchecked;
  { test clicking on a checkbox without "otoNoSelection in Options": The first click
    selects the cell, the second toggles the checkbox. }
  with FForm.OvcTable2 do begin
    Options := Options - [otoNoSelection];
    SetActiveCell(0,0);
    SetFocus;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONDOWN, 0, 5*65536+400);
    Application.ProcessMessages;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONUP, 0, 5*65536+400);
    Application.ProcessMessages;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONDOWN, 0, 5*65536+400);
    Application.ProcessMessages;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONUP, 0, 5*65536+400);
    Application.ProcessMessages;
    StopEditingState(True);
  end;
  CheckTrue(FForm.Data_OvcTCCheckBox1=cbChecked,
            'Clicking on a OvcTCCheckbox failed when otoNoSelection not in Options');
  CheckEquals(-1, FForm.Data_Overflow_OvcTCCheckBox1, 'Data overflow for OvcTCCheckBox1');

  FForm.Data_OvcTCCheckBox1 := cbUnchecked;
  { test clicking on a checkbox with "otoNoSelection in Options": The first click toggles the
    checkbox. }
  with FForm.OvcTable2 do begin
    Options := Options + [otoNoSelection];
    SetActiveCell(0,0);
    SetFocus;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONDOWN, 0, 5*65536+400);
    Application.ProcessMessages;
    PostMessage(FForm.ActiveControl.Handle, WM_LBUTTONUP, 0, 5*65536+400);
    Application.ProcessMessages;
    StopEditingState(True);
  end;
  CheckTrue(FForm.Data_OvcTCCheckBox1=cbChecked,
            'Clicking on a OvcTCCheckbox failed when otoNoSelection in Options');
  CheckEquals(-1, FForm.Data_Overflow_OvcTCCheckBox1, 'Data overflow for OvcTCCheckBox1');
end;


procedure TTestOvcTable.SetUp;
begin
  inherited SetUp;
  FForm := TfrmTestOvcPictureField.Create(nil);
  FForm.Show;
  Application.ProcessMessages;
end;

procedure TTestOvcTable.TearDown;
begin
  FForm.Free;
  inherited TearDown;
end;

initialization
  RegisterTest(TTestOvcTable.Suite);

end.
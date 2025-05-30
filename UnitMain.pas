﻿unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edtTask: TEdit;
    Label1: TLabel;
    btnAddSaveTask: TButton;
    lstTasks: TListBox;
    lblTasks: TLabel;
    btnRemoveTask: TButton;
    btnClearAll: TButton;
    chkMarkDone: TCheckBox;
    btnEditTask: TButton;
    btnSaveInArchive: TButton;
    procedure btnAddSaveTaskClick(Sender: TObject);
    procedure btnRemoveTaskClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure chkMarkDoneClick(Sender: TObject);
    procedure lstTasksClick(Sender: TObject);
    procedure edtTaskKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditTaskClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveInArchiveClick(Sender: TObject);
    procedure lstTasksDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lstTasksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    IsUpdating: Boolean;
    const
      TAG_ADD = 0;
      TAG_EDIT = 1;
      FILE_TASKS = 'tasks.txt';
    procedure UpdateTotalTasks;
    procedure LoadTasksFromFile(filename: string = FILE_TASKS);
    procedure SaveTasksToFile(filename: string = FILE_TASKS);
    procedure SaveTaskEddited(task: string);
    procedure AddNewTask(task: string);
    procedure UpdateCheckbox(task: string = '');
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateCheckbox(task: string = '');
begin
  IsUpdating := True;
  chkMarkDone.Checked := task.Contains('✔ ');
  IsUpdating := False;
end;

procedure TForm1.UpdateTotalTasks;
begin
  lblTasks.Caption := 'Tarefas - ' + FormatFloat('000', lstTasks.Items.Count);
end;

procedure TForm1.LoadTasksFromFile(filename: string = FILE_TASKS);
begin
  if FileExists(filename) then
    lstTasks.Items.LoadFromFile(filename);
end;

procedure TForm1.SaveTasksToFile(filename: string = FILE_TASKS);
begin
  lstTasks.Items.SaveToFile(filename, TEncoding.UTF8);
  MessageDlg('Suas tarefas foram salvas para próxima vez que reabrir o sistema!',
    mtInformation, [mbOk], 0);
end;

procedure TForm1.SaveTaskEddited(task: string);
var
  taskEddited: string;
begin
  if chkMarkDone.Checked then
    taskEddited := '✔ ';
  taskEddited := taskEddited + task;
  lstTasks.Items[lstTasks.ItemIndex] := taskEddited;

  btnAddSaveTask.Tag := TAG_ADD;
  btnAddSaveTask.Caption := 'Nova Tarefa';
end;

procedure TForm1.AddNewTask(task: string);
begin
  lstTasks.Items.Add(task)
end;

procedure TForm1.btnAddSaveTaskClick(Sender: TObject);
var
  task: string;
begin
  task := Trim(edtTask.Text);


  if task <> '' then
  begin
    if btnAddSaveTask.Tag = TAG_ADD then
      AddNewTask(task)
    else if btnAddSaveTask.Tag = TAG_EDIT then
      SaveTaskEddited(task);

    UpdateTotalTasks;
    edtTask.Clear;
    edtTask.SetFocus;
  end
  else
    MessageDlg('Digite uma tarefa.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnClearAllClick(Sender: TObject);
begin
  if lstTasks.Items.Count > 0 then
  begin
    lstTasks.Clear;
    UpdateCheckbox;
    UpdateTotalTasks;
  end
  else
    MessageDlg('Não há tarefas para limpar.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnEditTaskClick(Sender: TObject);
var
  task: string;
begin
  if lstTasks.ItemIndex >= 0 then
  begin
    task := lstTasks.Items[lstTasks.ItemIndex];
    if task.StartsWith('✔ ') then
      edtTask.Text := Copy(task, 3, Length(task))
    else
      edtTask.Text := task;

    edtTask.SetFocus;
    btnAddSaveTask.Tag := TAG_EDIT;
    btnAddSaveTask.Caption := 'Salvar alteração';
  end
  else
    MessageDlg('Selecione uma tarefa para editar.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnRemoveTaskClick(Sender: TObject);
var
  CanRemove: Boolean;
begin
  if lstTasks.ItemIndex >= 0 then
  begin
    CanRemove := MessageDlg('Tem certeza que você quer remover essa task?',
       mtConfirmation, [mbNo, mbYes], 0) = mrYes;

    if CanRemove then
    begin
      lstTasks.Items.Delete(lstTasks.ItemIndex);
      UpdateCheckbox;
      UpdateTotalTasks;
    end
    else
      MessageDlg('Procedimento Cancelado, a Task não foi removida!', mtInformation, [mbOk], 0);
  end
  else
    MessageDlg('Selecione uma tarefa para remover.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnSaveInArchiveClick(Sender: TObject);
begin
  SaveTasksToFile;
end;

procedure TForm1.chkMarkDoneClick(Sender: TObject);
var
  indexTask: integer;
  task: string;
begin
  if IsUpdating then
    Exit;

  indexTask := lstTasks.ItemIndex;

  if indexTask < 0 then
  begin
    MessageDlg('Selecione uma tarefa para concluir.', mtInformation, [mbOk], 0);

    IsUpdating := True;
    chkMarkDone.Checked := False;
    IsUpdating := False;

    Exit;
  end;

  task := lstTasks.Items[indexTask];

  if chkMarkDone.Checked then
  begin
    if not task.StartsWith('✔ ') then
      lstTasks.Items[indexTask] := '✔ ' + task;
  end
  else
  begin
    if task.StartsWith('✔ ') then
      lstTasks.Items[indexTask] := Copy(task, 3, Length(task));
  end;

end;

procedure TForm1.edtTaskKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnAddSaveTask.Click;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  LoadTasksFromFile;
  UpdateTotalTasks;
end;

procedure TForm1.lstTasksClick(Sender: TObject);
var
  task: string;
begin
  if lstTasks.ItemIndex >= 0 then
  begin
    task := lstTasks.Items[lstTasks.ItemIndex];
    UpdateCheckbox(task);
  end;

end;

procedure TForm1.lstTasksDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  task: string;
begin
  task := lstTasks.Items[Index];

  if odSelected in State then
  begin
    lstTasks.Canvas.Brush.Color := clHighlight;
    lstTasks.Canvas.Font.Style := [fsBold];
  end
  else
  begin
    if task.StartsWith('✔ ') then
    begin
      lstTasks.Canvas.Font.Color := clGreen;
      lstTasks.Canvas.Font.Style := [fsItalic, fsStrikeOut];
    end
    else
      lstTasks.Canvas.Font.Color := clWindowText;

    lstTasks.Canvas.Brush.Color := clWindow;
  end;

  lstTasks.Canvas.FillRect(Rect);
  lstTasks.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, task);

end;

procedure TForm1.lstTasksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  indexTask: integer;
begin
  if Key = VK_DELETE then
  begin
    btnRemoveTask.Click;
  end;
end;

end.

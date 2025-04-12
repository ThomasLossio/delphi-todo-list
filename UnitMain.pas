unit UnitMain;

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
  private
    { Private declarations }
    IsUpdating: Boolean;
    procedure UpdateTotalTasks;
    const
      TAG_ADD = 0;
      TAG_EDIT = 1;
      FILE_TASKS = 'tasks.txt';
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

procedure TForm1.btnAddSaveTaskClick(Sender: TObject);
var
  task, taskEddited: string;
begin
  task := Trim(edtTask.Text);
  taskEddited := '';

  if task <> '' then
  begin
    if btnAddSaveTask.Tag = TAG_ADD then
      lstTasks.Items.Add(task)
    else if btnAddSaveTask.Tag = TAG_EDIT then
    begin
      if chkMarkDone.Checked then
        taskEddited := '✔ ';
      taskEddited := taskEddited + task;
      lstTasks.Items[lstTasks.ItemIndex] := taskEddited;

      btnAddSaveTask.Tag := TAG_ADD;
    end;

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
begin
  if lstTasks.ItemIndex >= 0 then
  begin
    lstTasks.Items.Delete(lstTasks.ItemIndex);
    UpdateCheckbox;
    UpdateTotalTasks;
  end
  else
    MessageDlg('Selecione uma tarefa para remover.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnSaveInArchiveClick(Sender: TObject);
begin
  lstTasks.Items.SaveToFile(FILE_TASKS);
  MessageDlg('Suas tarefas foram salvas para próxima vez que reabrir o sistema!',
    mtInformation, [mbOk], 0);
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
  if FileExists(FILE_TASKS) then
    lstTasks.Items.LoadFromFile(FILE_TASKS);

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

end.

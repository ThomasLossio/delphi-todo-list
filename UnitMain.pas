unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edtTask: TEdit;
    Label1: TLabel;
    btnAddTask: TButton;
    lstTasks: TListBox;
    lblTasks: TLabel;
    btnRemoveTask: TButton;
    btnClearAll: TButton;
    chkMarkDone: TCheckBox;
    procedure btnAddTaskClick(Sender: TObject);
    procedure btnRemoveTaskClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure chkMarkDoneClick(Sender: TObject);
    procedure lstTasksClick(Sender: TObject);
  private
    { Private declarations }
    IsUpdating: Boolean;
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

procedure TForm1.btnAddTaskClick(Sender: TObject);
var
  task: string;
begin
  task := Trim(edtTask.Text);
  if task <> '' then
  begin
    lstTasks.Items.Add(task);
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
  end
  else
    MessageDlg('Não há tarefas para limpar.', mtInformation, [mbOk], 0);
end;

procedure TForm1.btnRemoveTaskClick(Sender: TObject);
begin
  if lstTasks.ItemIndex >= 0 then
  begin
    lstTasks.Items.Delete(lstTasks.ItemIndex);
    UpdateCheckbox;
  end
  else
    MessageDlg('Selecione uma tarefa para remover.', mtInformation, [mbOk], 0);
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

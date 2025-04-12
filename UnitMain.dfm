object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'To-Do List'
  ClientHeight = 415
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 5
    Top = 46
    Width = 32
    Height = 15
    Caption = 'Tarefa'
  end
  object lblTasks: TLabel
    Left = 5
    Top = 102
    Width = 37
    Height = 15
    Caption = 'Tarefas'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 41
    Align = alTop
    Caption = 'To-Do List'
    TabOrder = 0
  end
  object edtTask: TEdit
    Left = 5
    Top = 64
    Width = 285
    Height = 23
    TabOrder = 1
    OnKeyPress = edtTaskKeyPress
  end
  object btnAddSaveTask: TButton
    Left = 296
    Top = 63
    Width = 102
    Height = 25
    Caption = 'Nova Tarefa'
    TabOrder = 2
    OnClick = btnAddSaveTaskClick
  end
  object lstTasks: TListBox
    Left = 5
    Top = 117
    Width = 393
    Height = 209
    ItemHeight = 15
    TabOrder = 3
    OnClick = lstTasksClick
  end
  object btnRemoveTask: TButton
    Left = 5
    Top = 347
    Width = 102
    Height = 25
    Caption = 'Remover Tarefa'
    TabOrder = 4
    OnClick = btnRemoveTaskClick
  end
  object btnClearAll: TButton
    Left = 296
    Top = 382
    Width = 102
    Height = 25
    Caption = 'Limpar Tudo'
    TabOrder = 5
    OnClick = btnClearAllClick
  end
  object chkMarkDone: TCheckBox
    Left = 142
    Top = 351
    Width = 118
    Height = 17
    Caption = 'Marcar Conclu'#237'do'
    TabOrder = 6
    OnClick = chkMarkDoneClick
  end
  object btnEditTask: TButton
    Left = 296
    Top = 347
    Width = 102
    Height = 25
    Caption = 'Editar Tarefa'
    TabOrder = 7
    OnClick = btnEditTaskClick
  end
end

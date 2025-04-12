object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'To-Do List'
  ClientHeight = 383
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
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
    Width = 312
    Height = 23
    TabOrder = 1
  end
  object btnAddTask: TButton
    Left = 323
    Top = 63
    Width = 75
    Height = 25
    Caption = 'Nova Tarefa'
    TabOrder = 2
    OnClick = btnAddTaskClick
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
    Top = 347
    Width = 102
    Height = 25
    Caption = 'Limpar Tudo'
    TabOrder = 5
    OnClick = btnClearAllClick
  end
  object chkMarkDone: TCheckBox
    Left = 144
    Top = 351
    Width = 118
    Height = 17
    Caption = 'Marcar Conclu'#237'do'
    TabOrder = 6
    OnClick = chkMarkDoneClick
  end
end

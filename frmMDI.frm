VERSION 5.00
Begin VB.MDIForm frmMDI 
   BackColor       =   &H8000000C&
   Caption         =   "����ͼ����� & ��������"
   ClientHeight    =   5265
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   7080
   Icon            =   "frmMDI.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   2  '��Ļ����
   Begin FunctionImage.ToolBarContainer tbcToolBar 
      Align           =   1  'Align Top
      Height          =   390
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   688
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   0
         Left            =   120
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":74F2
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   1
         Left            =   600
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":764C
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   2
         Left            =   960
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":77A6
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   3
         Left            =   1320
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7900
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   4
         Left            =   1680
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7A5A
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   5
         Left            =   2040
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7BB4
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   6
         Left            =   2400
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7D0E
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   7
         Left            =   2760
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7E68
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   8
         Left            =   3120
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":7FC2
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   9
         Left            =   3600
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":811C
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   10
         Left            =   3960
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":822E
      End
      Begin FunctionImage.ToolButton tbButtons 
         Height          =   360
         Index           =   11
         Left            =   4440
         Top             =   15
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         Picture         =   "frmMDI.frx":8340
      End
   End
   Begin VB.Menu mnuFunction 
      Caption         =   "����(&F)"
      Begin VB.Menu mnuFunctionDraw 
         Caption         =   "�������⺯��(&D)"
      End
      Begin VB.Menu mnuFunctionSep0 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFunctionLinear 
         Caption         =   "һ�κ���(&I)"
      End
      Begin VB.Menu mnuFunctionInverse 
         Caption         =   "����������(&I)"
      End
      Begin VB.Menu mnuFunction2 
         Caption         =   "���κ���(&2)"
      End
      Begin VB.Menu mnuFunctionPower 
         Caption         =   "�ݺ���(&P)"
      End
      Begin VB.Menu mnuFunctionSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFunctionAx 
         Caption         =   "ָ������(&A)"
      End
      Begin VB.Menu mnuFunctionLog 
         Caption         =   "��������(&L)"
      End
      Begin VB.Menu mnuFunctionTriangle 
         Caption         =   "���Ǻ���(&T)"
      End
      Begin VB.Menu mnuFunctionHyp 
         Caption         =   "˫������(&H)"
      End
      Begin VB.Menu mnuFunctionSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFunctionExit 
         Caption         =   "�˳�(&X)"
      End
   End
   Begin VB.Menu mnuGeo 
      Caption         =   "��������(&G)"
      Begin VB.Menu mnuGeoD 
         Caption         =   "����֮�����(&D)"
      End
      Begin VB.Menu mnuGeoS 
         Caption         =   "��֪�����������������(&S)"
      End
      Begin VB.Menu mnuGeoLine 
         Caption         =   "ֱ��(&L)"
         Begin VB.Menu mnuGeoLineT 
            Caption         =   "��б�Ǻ�б��(&T)"
         End
         Begin VB.Menu mnuGeoLineP 
            Caption         =   "���ȷֵ�(&P)"
         End
         Begin VB.Menu mnuGeoLineE 
            Caption         =   "���鹫ʽ(&E)"
         End
         Begin VB.Menu mnuGeoLineN 
            Caption         =   "ֱ�߷��̵ķ���ʽ(&N)"
            Begin VB.Menu mnuGeoLineC 
               Caption         =   "��ֱ�߽���(&C)"
            End
            Begin VB.Menu mnuGeoLineNN 
               Caption         =   "��׼���̻�Ϊ����ʽ(&N)"
            End
            Begin VB.Menu mnuGeoLineND 
               Caption         =   "�㵽ֱ�ߵľ���(&D)"
            End
            Begin VB.Menu mnuGeoLineNE 
               Caption         =   "����ƽ�е�ֱ��֮��ľ���(&E)"
            End
            Begin VB.Menu mnuGeoLineNA 
               Caption         =   "����ֱ�ߵļн�(&A)"
            End
         End
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "����(&H)"
      Begin VB.Menu mnuHelpAbout 
         Caption         =   "����(&A)"
      End
   End
End
Attribute VB_Name = "frmMDI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub MDIForm_Load()
'
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    On Error Resume Next
    
    Dim i As Integer
    For i = 0 To Forms.Count - 1
        Unload Forms(i)
    Next
    
    Set ImageWindows = Nothing
End Sub

Private Sub mnuFunctionDraw_Click()
    Dim f As frmDrawFunction
    Set f = New frmDrawFunction
    f.Show
    Set f = Nothing
End Sub

Private Sub mnuFunctionLinear_Click()
    Dim f As frmLinearFunction
    Set f = New frmLinearFunction
    f.Show
    Set f = Nothing
End Sub

Private Sub mnuHelpAbout_Click()
    On Error Resume Next
    frmAbout.Show vbModal
End Sub

Private Sub tbButtons_Click(Index As Integer)
    Dim f As Form
    Select Case Index
        Case 0
            mnuFunctionDraw_Click
        Case 1
            mnuFunctionLinear_Click
        Case 11
            mnuHelpAbout_Click
    End Select
End Sub

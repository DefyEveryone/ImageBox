Attribute VB_Name = "modCalculator"
Option Explicit

Const PI As Double = 3.14159265358979               ' ������

Private tmpChar As String

' ���ַ������м��㡣
' ÿ�������е� Expression ��ʾ��Ҫ����ı��ʽ��
' ���� IsValid ���Ϊ True�����ʾ���ʽ��Ч������ֵ�Ǽ����Ľ����
' ���� XValue ��ʾ������ʽ�г����ˡ�x�����Ͱ� XValue ��ֵ���뵽 x �С�
Public Function CalculateString(ByVal Expression As String, ByRef IsValid As Boolean, Optional XValue As Double = 0, Optional XLetter As String = "X") As Double
    ' ���ر��ʽ���ܳ��ȡ�
    Dim ExpressionLength As Long
    ' ���ؼ������֮�������λ�á�
    Dim ParserPosition As Integer
    
    If XLetter = "" Then tmpChar = "X" Else tmpChar = Left(UCase(XLetter), 1)
    
    ParserPosition = 1
    ' ����Ҫ��Բ�����滻����ֵ��
    ' �����ǰ�ֵ���ݣ�Expression �ǲ��ᱻ���ĵġ�
    Expression = Replace(Expression, "pi", CStr(PI), , , vbTextCompare)
    ExpressionLength = Len(Expression)
    ' ���ڼӼ������������ģ����ԼӼ��������ˣ�ʽ��Ҳ�������ˡ�
    CalculateString = AddMinusParser(UCase(Expression), IsValid, ParserPosition, XValue)
    ' ������ʽû�б�������ɣ���˵�����ʽ�����⡣
    If ParserPosition <= ExpressionLength Then IsValid = False
End Function

' ���мӼ��������㡣
' Position ��ʾ�Ѿ���������λ�á�
Private Function AddMinusParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    On Error GoTo ErrorHandler
    ' ���ڳ˳����ϼӼ������ȣ������ȼ���˳�����
    ' �����㷨�ǽ� 1 * 2 / 3 ^ 4 + 2 * 3 / 4 ^ 5 ��� (1 * 2 / 3 ^ 4) + (2 * 3 / 4 ^ 5)
    Tmp1 = MulDivParser(Expression, IsValid, Position, XValue)
    If Match(Expression, "+", Position) Then
        Position = Position + 1
        ' �ڵڶ����������ٴν������㡣
        Tmp2 = AddMinusParser2(Expression, IsValid, Position, XValue, False)
        If IsValid = False Then Exit Function
        AddMinusParser = Tmp1 + Tmp2
    ElseIf Match(Expression, "-", Position) Then
        Position = Position + 1
        ' �ڵڶ����������ٴν������㡣
        '*�˴��������⣺����������� 1 - 2 + 3 ����ʽ�������Ὣ�䴦��� 1 - (2 + 3)��
        ' �����Ѿ��õ������
        Tmp2 = AddMinusParser2(Expression, IsValid, Position, XValue, True)
        If IsValid = False Then Exit Function
        AddMinusParser = Tmp1 - Tmp2
    Else
        ' Ӧ���������ˡ�
        AddMinusParser = Tmp1
    End If
    Exit Function
ErrorHandler:
    IsValid = False
End Function

' �ڵڶ����������ٴν��мӼ������㡣
' SignReverse ��ʾ��ÿ���������ķ��ű�һ�£�
' Ŀ���ǽ�� 1 - 2 + 3 = 1 - (2 + 3) �����⡣
Private Function AddMinusParser2(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double, ByVal SignReverse As Boolean) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    ' �ڵڶ����������ٴ�Ѱ�ҵ�һ��������
    Tmp1 = MulDivParser2(Expression, IsValid, Position, XValue, False)
    If Match(Expression, "+", Position) Then
        Position = Position + 1
        Tmp2 = AddMinusParser2(Expression, IsValid, Position, XValue, False)
        If IsValid = False Then Exit Function
        ' ��� 1 - 2 + 3 = 1 - (2 + 3) �����⡣
        If SignReverse Then AddMinusParser2 = Tmp1 - Tmp2 Else AddMinusParser2 = Tmp1 + Tmp2
    ElseIf Match(Expression, "-", Position) Then
        Position = Position + 1
        Tmp2 = AddMinusParser2(Expression, IsValid, Position, XValue, True)
        If IsValid = False Then Exit Function
        ' ��� 1 - 2 + 3 = 1 - (2 + 3) �����⡣
        If SignReverse Then AddMinusParser2 = Tmp1 + Tmp2 Else AddMinusParser2 = Tmp1 - Tmp2
    Else
        AddMinusParser2 = Tmp1
    End If
End Function

' ���г˳��������㡣
Private Function MulDivParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    ' �ȼ���˷���
    Tmp1 = PowerParser(Expression, IsValid, Position, XValue)
    If IsValid = False Then Exit Function
    If Match(Expression, "*", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = MulDivParser2(Expression, IsValid, Position, XValue, False)
        If IsValid = False Then Exit Function
        MulDivParser = Tmp1 * Tmp2
    ElseIf Match(Expression, "/", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = MulDivParser2(Expression, IsValid, Position, XValue, True)
        If IsValid = False Then Exit Function
        MulDivParser = Tmp1 / Tmp2
    Else
        MulDivParser = Tmp1
    End If
End Function

' �ڵڶ����������ٴν��г˳������㡣
' SignReverse ��ʾ��ÿ���������ķ��ű�һ�£�
' Ŀ���ǽ�� 1 / 2 * 3 = 1 / (2 * 3) �����⡣
Private Function MulDivParser2(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double, ByVal SignReverse As Boolean) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    ' �ȼ���˷���
    Tmp1 = PowerParser2(Expression, IsValid, Position, XValue)
    If IsValid = False Then Exit Function
    If Match(Expression, "*", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = MulDivParser2(Expression, IsValid, Position, XValue, False)
        If IsValid = False Then Exit Function
        If SignReverse = True Then MulDivParser2 = Tmp1 / Tmp2 Else MulDivParser2 = Tmp1 * Tmp2
    ElseIf Match(Expression, "/", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = MulDivParser2(Expression, IsValid, Position, XValue, True)
        If IsValid = False Then Exit Function
        If SignReverse = True Then MulDivParser2 = Tmp1 * Tmp2 Else MulDivParser2 = Tmp1 / Tmp2
    Else
        MulDivParser2 = Tmp1
    End If
End Function

' ���г˷����㡣
Private Function PowerParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    ' �ȼ��㺯��ֵ��
    Tmp1 = FunctionCalc(Expression, IsValid, Position, XValue)
    If IsValid = False Then Exit Function
    If Match(Expression, "^", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = FunctionCalc2(Expression, IsValid, Position, XValue)
        If IsValid = False Then Exit Function
        PowerParser = Tmp1 ^ Tmp2
    Else
        PowerParser = Tmp1
    End If
End Function

' �ڵڶ��������н��г˷����㡣
Private Function PowerParser2(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    ' �����һ��������
    Tmp1 = FunctionCalc2(Expression, IsValid, Position, XValue)
    If IsValid = False Then Exit Function
    If Match(Expression, "^", Position) Then
        Position = Position + 1
        ' ����ڶ���������
        Tmp2 = FunctionCalc2(Expression, IsValid, Position, XValue)
        If IsValid = False Then Exit Function
        PowerParser2 = Tmp1 ^ Tmp2
    Else
        PowerParser2 = Tmp1
    End If
End Function

'��ȡ���ķ���
Private Function FunctionCalc(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim tmp As Double
    
    tmp = SignParser(Expression, IsValid, Position, XValue)
    If IsValid = False Then tmp = FunctionParser(Expression, IsValid, Position, XValue)
    FunctionCalc = tmp
    
End Function

'��ȡ�������ģ�
Private Function FunctionCalc2(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim tmp As Double
    
    tmp = NumberParser(Expression, IsValid, Position, XValue)
    If IsValid = False Then tmp = FunctionParser(Expression, IsValid, Position, XValue)
    FunctionCalc2 = tmp
    
End Function

' ���㺯����
' �������º�����
' sin, cos, tan, cot, sec, csc, sh, ch, th, cth, sch, csch,
' arctan, arcsin, arccos, arsh, arch, arth, sqrt, log, lg, ln, exp,
' abs, sgn, int, degrees, radians,
' ������ӣ�Ceil�����ش��ڵ�����������С��������Floor������С�ڵ������������������
'           Min��Max��Round��Fac���׳ˣ���Mod��ȡ��������Rand���������

Private Function FunctionParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim Tmp1 As Double, Tmp2 As Double
    
    Dim d As Double, x As Double
    Call PassBlank(Expression, Position)
    If Match(Expression, "SIN", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Sin(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "COS", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Cos(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "TAN", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Tan(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "COT", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        If Abs(d / (Atn(1) * 2)) Mod 2 = 1 Then
            FunctionParser = 0
        Else
            FunctionParser = 1 / Tan(BracketsParser(Expression, IsValid, Position, XValue))
        End If
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "SEC", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = 1 / Cos(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "COSEC", Position) Or Match(Expression, "CSC", Position) Then
        Position = Position + 5
        Call PassBlank(Expression, Position)
        FunctionParser = 1 / Sin(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "SH", Position) Then
        Position = Position + 2
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = (Exp(d) - Exp(-d)) / 2
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "CH", Position) Then
        Position = Position + 2
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = (Exp(d) + Exp(-d)) / 2
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "TH", Position) Then
        Position = Position + 2
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = (Exp(d) - Exp(-d)) / (Exp(d) + Exp(-d))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "CTH", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = (Exp(d) + Exp(-d)) / (Exp(d) - Exp(-d))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "SCH", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = 2 / (Exp(d) + Exp(-d))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "CSCH", Position) Then
        Position = Position + 4
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = 2 / (Exp(d) - Exp(-d))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARSH", Position) Then
        Position = Position + 4
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = Log(d + Sqr(x ^ 2 + 1))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARCH", Position) Then
        Position = Position + 4
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = Log(x + Sqr(x ^ 2 - 1))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARTH", Position) Then
        Position = Position + 4
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = Log((1 + d) / (1 - d)) / 2
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "SQRT", Position) Or Match(Expression, "SQR", Position) Then
        Position = Position + 4
        Call PassBlank(Expression, Position)
        d = BracketsParser(Expression, IsValid, Position, XValue)
        FunctionParser = Sqr(d)
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "LOG", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        If Match(Expression, "(", Position) Then
            Position = Position + 1
            Tmp1 = AddMinusParser(Expression, IsValid, Position, XValue)
            If Match(Expression, ",", Position) And IsValid Then
                Position = Position + 1
                Tmp2 = AddMinusParser(Expression, IsValid, Position, XValue)
                If Match(Expression, ")", Position) And IsValid Then
                    Position = Position + 1
                    Call PassBlank(Expression, Position)
                    IsValid = True
                    FunctionParser = Log(Tmp2) / Log(Tmp1)
                    Exit Function
                End If
            End If
        End If
        IsValid = False
        Exit Function
    End If
    If Match(Expression, "LG", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Log(BracketsParser(Expression, IsValid, Position, XValue)) / Log(10#)
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "LN", Position) Then
        Position = Position + 2
        Call PassBlank(Expression, Position)
        FunctionParser = Log(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "EXP", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Exp(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ABS", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Abs(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "SGN", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Sgn(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "INT", Position) Then
        Position = Position + 3
        Call PassBlank(Expression, Position)
        FunctionParser = Int(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "DEGREES", Position) Then
        Position = Position + 7
        Call PassBlank(Expression, Position)
        FunctionParser = BracketsParser(Expression, IsValid, Position, XValue) / PI * 180
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "RADIANS", Position) Then
        Position = Position + 7
        Call PassBlank(Expression, Position)
        FunctionParser = BracketsParser(Expression, IsValid, Position, XValue) / 180 * PI
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARCTAN", Position) Then
        Position = Position + 6
        Call PassBlank(Expression, Position)
        FunctionParser = Atn(BracketsParser(Expression, IsValid, Position, XValue))
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARCSIN", Position) Then
        Position = Position + 6
        Call PassBlank(Expression, Position)
        Tmp1 = BracketsParser(Expression, IsValid, Position, XValue)
        If Tmp1 <> 1 And Tmp1 <> -1 Then
            FunctionParser = Atn(Tmp1 / Sqr(1 - Tmp1 * Tmp1))
        Else
            If Tmp1 = 1 Then FunctionParser = PI / 2 Else FunctionParser = -PI / 2
        End If
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "ARCCOS", Position) Then
        Position = Position + 6
        Call PassBlank(Expression, Position)
        Tmp1 = BracketsParser(Expression, IsValid, Position, XValue)
        If Tmp1 <> 1 And Tmp1 <> -1 Then
            FunctionParser = PI / 2 - Atn(Tmp1 / Sqr(1 - Tmp1 * Tmp1))
        Else
            If Tmp1 = 1 Then FunctionParser = 0# Else FunctionParser = PI
        End If
        Call PassBlank(Expression, Position)
        Exit Function
    End If
'    If Match(Expression, "POW", Position) Then
'        Position = Position + 3
'        Call PassBlank(Expression, Position)
'        If Match(Expression, "(", Position) Then
'            Position = Position + 1
'            Tmp1 = AddMinusParser(Expression, IsValid, Position, XValue)
'            If Match(Expression, ",", Position) And IsValid Then
'                Position = Position + 1
'                Tmp2 = AddMinusParser(Expression, IsValid, Position, XValue)
'                If Match(Expression, ")", Position) And IsValid Then
'                    Position = Position + 1
'                    Call PassBlank(Expression, Position)
'                    IsValid = True
'                    FunctionParser = Tmp1 ^ Tmp2
'                    Exit Function
'                End If
'            End If
'        End If
'        IsValid = False
'        Exit Function
'    End If
    FunctionParser = BracketsParser(Expression, IsValid, Position, XValue)
    Call PassBlank(Expression, Position)
End Function

' ���������ڵ����ͱ��ʽ��
Private Function BracketsParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim tmp As Double
    
    If Match(Expression, "(", Position) Then
        Position = Position + 1
        Call PassBlank(Expression, Position)
        ' ������������һ�����ʽ��
        tmp = AddMinusParser(Expression, IsValid, Position, XValue)
        If IsValid And Match(Expression, ")", Position) Then
            BracketsParser = tmp
            Position = Position + 1
            IsValid = True
        Else
            IsValid = False
        End If
    End If
End Function

' ��ȡ���ʽ�е�����
Private Function NumberParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    ' Tmp1 ����ȡ����������Tmp2 ��ʾ�ڱ��ʽ����ȡ��λ�ã�����������ԣ���
    Dim Tmp1 As Double, Tmp2 As Double
    Dim TmpStr As String
    Call PassBlank(Expression, Position)
    
    ' ������ʽ�к���δ֪�� x����ô�Ͱ� XValue ���뵽 x �С�
    If Match(Expression, tmpChar, Position) Then
        NumberParser = XValue
        IsValid = True
        Position = Position + 1
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    
    Tmp1 = 0
    Tmp2 = 0
    TmpStr = Mid(Expression, Position, 1)
    
    ' ���û����ȡ����Ч�ַ������������ֵĵ�һλ�����Բ����С�e��������ָ���������
    If (TmpStr >= "0" And TmpStr <= "9") Or TmpStr = "." Then
        ' ���������֣��� + С���� + С�� + e + ָ��
        While TmpStr >= "0" And TmpStr <= "9" Or TmpStr = " "
            Tmp2 = Tmp2 + 1
            TmpStr = Mid(Expression, Position + Tmp2, 1)
        Wend
        
        If TmpStr = "." Then Tmp2 = Tmp2 + 1
        TmpStr = Mid(Expression, Position + Tmp2, 1)
        
        While TmpStr >= "0" And TmpStr <= "9" Or TmpStr = " "
            Tmp2 = Tmp2 + 1
            TmpStr = Mid(Expression, Position + Tmp2, 1)
        Wend
        
        If TmpStr = "E" Then Tmp2 = Tmp2 + 1
        TmpStr = Mid(Expression, Position + Tmp2, 1)
        
        While TmpStr >= "0" And TmpStr <= "9" Or TmpStr = " "
            Tmp2 = Tmp2 + 1
            TmpStr = Mid(Expression, Position + Tmp2, 1)
        Wend
        
        ' �����һ�в�������Ϊ��Ѱ����ֵ���ʽ�ĳ��ȣ���������ȡ���֡�
        Tmp1 = Val(Mid(Expression, Position))
        Position = Position + Tmp2
        IsValid = True
    Else
        IsValid = False
    End If
    NumberParser = Tmp1
End Function

' ��������ŵ�����
Private Function SignParser(ByVal Expression As String, ByRef IsValid As Boolean, ByRef Position As Integer, ByVal XValue As Double) As Double
    Dim tmp As Double
    Dim Sign As Integer
    Sign = 1
    Call PassBlank(Expression, Position)
    If Match(Expression, tmpChar, Position) Then
        SignParser = XValue
        IsValid = True
        Position = Position + 1
        Call PassBlank(Expression, Position)
        Exit Function
    End If
    If Match(Expression, "-", Position) Then
        Position = Position + 1
        Sign = -1
    ElseIf Match(Expression, "+", Position) Or (Mid(Expression, Position, 1) >= "0" And Mid(Expression, Position, 1) <= "9") Or Mid(Expression, Position, 1) = "." Then
        Sign = 1
    Else
        IsValid = False
        Exit Function
    End If
    tmp = FunctionCalc2(Expression, IsValid, Position, XValue)
    SignParser = tmp * Sign
End Function

' ��� Expression �� position λ���Ƿ�Ϊ Expression2
Private Function Match(ByVal Expression As String, ByVal Expression2 As String, ByRef Position As Integer) As Boolean
    If Mid(Expression, Position, Len(Expression2)) = Expression2 Then Match = True Else Match = False
End Function

' �ڷ������ʽ��ʱ��Ҫ�����ո�
Private Sub PassBlank(ByVal Expression As String, ByRef Position As Integer)
    While Mid(Expression, Position, 1) = " "
        Position = Position + 1
    Wend
End Sub


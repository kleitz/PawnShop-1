Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class MainEstimate
    Inherits System.Web.UI.Page

    Private Sub MainEstimate_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        'Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId
        Dim Emid As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).PrivateCode
        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId


        Dim username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim dt As New DataTable
        dt = CheckEstimateSecond(username)

        If dt.Rows.Count > 0 Then
            hiddenRoleEstimate2.Value = 1
        Else
            hiddenRoleEstimate2.Value = 0
        End If

        hiddenRole.Value = RoleID

        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../login.aspx")
            Exit Sub
        End If



    End Sub
End Class

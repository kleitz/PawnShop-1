Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class MenuControl_MenuUserControl
    Inherits System.Web.UI.UserControl

    Private Sub MenuControl_MenuUserControl_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim RoleId As Integer = tokenOb.RoleId
        Dim BranchId As Integer = tokenOb.BranchId

        Dim firstName As String = tokenOb.FirstName
        Dim lastName As String = tokenOb.LastName

        Dim fullName As String = firstName + " " + lastName

        'lblFullname.Text = fullName

    End Sub
End Class

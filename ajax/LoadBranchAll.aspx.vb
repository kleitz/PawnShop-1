Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_LoadBranchAll
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadBranchAll_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim RoleId As Integer = tokenOb.RoleId

        Dim BranchId As Integer = tokenOb.BranchId


        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getAllBracnh()

        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

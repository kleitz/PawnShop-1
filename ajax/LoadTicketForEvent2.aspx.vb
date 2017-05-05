Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Imports WebUtilFn
Partial Class ajax_LoadTicketForEvent2
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadTicketForEvent2_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim RoleId As Integer = tokenOb.RoleId

        Dim BranchId As Integer = tokenOb.BranchId

        Dim year As String = Request.Form("year")
        Dim month As String = Request.Form("month")
        Dim periodNo As Integer = Request.Form("period")

        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getTicketForEvent2(BranchId, year, month, periodNo)
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Imports WebUtilFn
Partial Class ajax_LoadTicketForEvent
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadTicketForEvent_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim RoleId As Integer = tokenOb.RoleId

        Dim BranchId As Integer = tokenOb.BranchId

        'Dim setNo As String = Request.Form("SetNo")

        Dim stDate As String = Request.Form("dateStart")
        Dim EndDate As String = Request.Form("dateEnd")

        Dim d1 As DateTime = Convert.ToDateTime(stDate, getDatetimeFormat)
        Dim d2 As DateTime = Convert.ToDateTime(EndDate, getDatetimeFormat)

        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getTicketForEvent(d1, d2)
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

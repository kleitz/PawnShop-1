Imports Newtonsoft.Json
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_getTicketInSet
    Inherits System.Web.UI.Page

    Private Sub ajax_getTicketInSet_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim ID As String = Request.Form("id")
        Dim dt As New DataTable
        dt = getTicketInSet(ID)
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

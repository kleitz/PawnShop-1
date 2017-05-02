Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_LoadMonth
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadMonth_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dt As New DataTable
        dt = getMonthTicket()
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

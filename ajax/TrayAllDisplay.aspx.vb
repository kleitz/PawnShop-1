Imports Newtonsoft.Json
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_TrayAllDisplay
    Inherits System.Web.UI.Page

    Private Sub ajax_TrayAllDisplay_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dt As New DataTable
        dt = getTrayAllDisplay()
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

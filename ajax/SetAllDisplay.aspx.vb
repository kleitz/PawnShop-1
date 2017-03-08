Imports Newtonsoft.Json
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_SetAllDisplay
    Inherits System.Web.UI.Page

    Private Sub ajax_SetAllDisplay_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dt As New DataTable
        dt = getSetAllDisplay()
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class

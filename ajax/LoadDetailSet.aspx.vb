Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_LoadDetailSet
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadDetailSet_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim ID As String = Request.Form("id")
        Dim dt As New DataTable
        dt = getSetDetail(ID)
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub

End Class

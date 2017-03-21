Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Imports System.Exception
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_getDataOnEvent
    Inherits System.Web.UI.Page

    Private Sub ajax_getDataOnEvent_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim eventId As String = Request.Form("eventid")

        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getTicketFromEventId(eventId)
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub


End Class

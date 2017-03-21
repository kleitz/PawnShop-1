Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Imports System.Exception
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_AddTicketOnEvent
    Inherits System.Web.UI.Page

    Private Sub ajax_AddTicketOnEvent_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId

        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId

        Dim Username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim json As String
        Using reader = New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim data As TicketOnEvent = JsonConvert.DeserializeObject(Of TicketOnEvent)(json)

        Dim eventId As String = data.eventid

        Try
            For value As Integer = 0 To data.Ticket.Count - 1
                addTicketOnEvent(data.Ticket(value), eventId, Username)
            Next

            Response.Write("success")
        Catch ex As Exception

        End Try

    End Sub
End Class

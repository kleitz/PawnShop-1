Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Imports System.IO
Partial Class ajax_SetTray
    Inherits System.Web.UI.Page

    Private Sub ajax_SetTray_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId

        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId

        Dim Username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim json As String
        Using reader = New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim data As SetTray = JsonConvert.DeserializeObject(Of SetTray)(json)
        Dim category As Integer = data.Category
        Dim weight As Decimal = data.weight
        Dim pricesum As Decimal = data.pricesum
        Dim secondEstimate As Decimal = data.secondEstimate
        Dim eventID As String = data.eventid

        Dim guids As String = Guid.NewGuid.ToString("D").ToUpper()
        Dim dt As New DataTable
        dt = getMaxTrayNo(eventID)

        Dim trayNo As Integer = 0
        trayNo = Integer.Parse(dt.Rows(0)("No").ToString())

        If trayNo = 0 Then
            trayNo = 1
        Else
            trayNo = trayNo + 1
        End If


        Try
            AddTray(guids, trayNo, category, pricesum, secondEstimate, BranchId, Username, eventID)
            For value As Integer = 0 To data.SetId.Count - 1
                AddTrayChild(guids, data.SetId(value).ToString(), Username)
                UpdateSettTray(data.SetId(value))
            Next

            Response.Write("Success")
        Catch ex As Exception

        End Try

    End Sub
End Class

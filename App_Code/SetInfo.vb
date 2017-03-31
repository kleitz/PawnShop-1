Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Public Class SetInfo
    Public Property Tickets As List(Of String)
    Public Property qty As Decimal
    Public Property weight As Decimal
    Public Property amt As Decimal
    Public Property estimate As Decimal
    Public Property eventId As String
    Public Property category As Integer

End Class

Public Class SetEdit
    Public Property SetID As String
    Public Property Weight As Decimal
    Public Property PriceSum As Decimal
    Public Property PriceEstimate As Decimal
End Class
Public Class SetTray
    Public Property SetId As List(Of String)
    Public Property Category As Integer
    Public Property weight As Decimal
    Public Property pricesum As Decimal
    Public Property secondEstimate As Decimal

    Public Property eventid As String

End Class
Public Class SetTrayEdit
    Public Property TrayID As String
    Public Property Category As Integer
    Public Property Amount As Decimal
    Public Property Estimate As Decimal

End Class
Public Class Branch
    Public Property BranchId As Integer
End Class

Public Class Tikets
    Public Property ticketString As String
End Class

Public Class TicketEstimate
    Public Property id As Integer
    Public Property TicketId As String
    Public Property TicketNo As String
    Public Property BookNo As String
    Public Property Amount As Decimal
    Public Property FirstEstimate As Decimal
    Public Property SecondEstimate As Decimal

    Public Property ReportNo As Integer


End Class

Public Class TicketOnEvent
    Public Property Ticket As List(Of String)
    Public Property eventid As String
End Class


Public Class eventid
    Public Property eventid As String
End Class


Public Class eventidBranch
    Public Property eventid As String
    Public Property branchid As Integer
End Class






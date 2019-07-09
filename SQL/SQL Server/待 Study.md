MAXDOP = 8
mtvfs

評價資料
訂單單筆







List<OrderItem> orderItem = 
GetAzureTableHelper(CompanyId)
.Query<OrderItem>()
.Where(x => x.CreateOn >= dtNowOneMonth 
            && x.Creater == EmployeeId 
            && !lstOrderIds.Contains(x.PartitionKey)).ToList();

CreateOn ge datetime'2019-06-09T02:09:36Z' 
and Creater eq guid'7ff2b47f-8e75-495f-9382-f9e96723f31b' 
and (PartitionKey ne '6f56adfb-3980-4b86-b6d4-f3db0a2bed8a')
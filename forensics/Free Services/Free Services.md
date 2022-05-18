Its a Excel 4.0 Macro workbook

Edit the macro inside the document and remove the CreateProcess, and WriteProcessMemory calls then set A5 to the below
```
=SET.VALUE(INDIRECT(ADDRESS(GET.CELL(6,C1),2)),CHAR(BITXOR(ACTIVE.CELL(),24)))
```

This will dump out the decoded chars and near the bottom is the flag
```
HTB{1s_th1s_g4l4xy_l0st_1n_t1m3??!}
```

GLOBAL_VAR_INIT(cmp_field, "name")

/proc/sortRecordNum(list/L, field = "name", order = 1)
	GLOB.cmp_field = field
	return sortTim(L, order >= 0 ? /proc/cmp_records_numeric_asc : /proc/cmp_records_numeric_dsc)

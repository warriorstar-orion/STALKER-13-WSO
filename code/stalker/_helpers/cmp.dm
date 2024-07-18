/proc/cmp_soundtracks_asc(datum/data/turntable_soundtrack/a, datum/data/turntable_soundtrack/b)
	return sorttext(b.f_name + b.name, a.f_name + a.name)

/proc/cmp_soundtracks_dsc(datum/data/turntable_soundtrack/a, datum/data/turntable_soundtrack/b)
	return sorttext(a.f_name + a.name, b.f_name + b.name)

/proc/cmp_records_numeric_dsc(datum/data/record/a, datum/data/record/b)
	return b.fields[GLOB.cmp_field] - a.fields[GLOB.cmp_field]

/proc/cmp_records_numeric_asc(datum/data/record/a, datum/data/record/b)
	return a.fields[GLOB.cmp_field] - b.fields[GLOB.cmp_field]

/proc/sortSoundtrack(list/L, order = 1)
	return sortTim(L, order >= 0 ? /proc/cmp_soundtracks_asc : /proc/cmp_soundtracks_dsc)

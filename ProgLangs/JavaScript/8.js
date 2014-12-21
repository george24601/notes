function lookupInEntry(name, entry, entryF) {
	return lookupInEntryHelp(name, first(entry), second(entry), entryF);
}

function lookupInEntryHelp(name, names, values, entry-f) {
	return isNull(names)? entry-f(name) :
		eq(name, car(names)) ? car(values) :
		lookupInEntryHelp(name, cdr(names), cdr(values), entry-f);
}

function lookupInTable(name, table, table-f) {
	return isNull(table)? table-f(name):
			lookupInEntry(name, car(table), function(n) {
						lookupInTable(name, cdr(table), table-f);
					}
				     );
}



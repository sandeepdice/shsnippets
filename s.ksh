#!/bin/ksh

pattern=$1
file_name=$2


found_line=`grep -n "^03,$pattern" $file_name | cut -d: -f1`

if [ ! -z $found_line ]
then
#	echo "found at line: $found_line"
	total_lines=`wc -l $file_name | awk '{print $1}'`
#	echo "total_lines: $total_lines"

	tail_lines=`expr $total_lines - $found_line + 1`
#	echo "tail_lines: $tail_lines"

	#end_line_plus_one=`cat $file_name | tail -$tail_lines | grep -n ^03, | head -2 | tail -1 | cut -d: -f1`
	lc_check=`cat $file_name | tail -$tail_lines | grep -n ^03 | wc -l`

	if [ $lc_check -eq 1 ]
	then 
	#	end_line_plus_one=`cat $file_name | grep -n "^03,$pattern" | cut -d: -f1`
	#	end_line=$end_line_plus_one
		end_line=$total_lines
#		echo "end_line: $end_line"
		start_line=`expr $end_line - $found_line + 1`
	else 
		end_line_plus_one=`cat $file_name | tail -$tail_lines | grep -n ^03, | head -2 | tail -1 | cut -d: -f1`
		end_line=`expr $end_line_plus_one - 2 + $found_line`
#		echo "end_line: $end_line"
		start_line=`expr $end_line - $found_line + 1`
	fi

#	echo "start at: $found_line, end at: $end_line"
#	echo;echo;
	cat $file_name | head -$end_line | tail -$start_line | grep ^16,
fi




=== REPLY ======================================================================

You are using an old Bourne shell (perhaps /bin/sh on Solaris?).

Switch to a standard UNIX shell (/usr/xpg4/bin/sh or ksh).

=== POST =======================================================================

I am unable to access the value set inside the loop from outside loop . 

Thought of taking this to forum , I had seen other replies also , where a pipe
takes the execution to another shell and mentioned thats the reason we do not
get the variable outside loop . But I am getting an issue and I am not using
pipe . A sample code below . I do not know where I am going wrong .Any help
would be highly appreciated.  (note my tree1.txt contains only 1 line , just
trying to test if I can access the value for a variable set inside a while
loop)

*************
count=0
while read line
do
count=10
echo $count
done < tree1.lst
echo count:$count

************Result**********
10
count:0


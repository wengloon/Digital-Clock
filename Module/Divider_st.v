/*!>
* Divider module
*
*+ Input +* 
* 6bit InData 		- Data source
* 3bit InDivisor	- Divisor value ( Max - decimal 16 )
*
*
*+ Output +* 
*  OutData - Output Data
*
*
<!*/
module Divider_st(
input [5:0] InData,
input [3:0] InDivisor,
output reg[3:0] OutData

);

always @(InData)
	begin
		OutData = InData/InDivisor;		//50/10=5 , ""5""
	end
	
endmodule 
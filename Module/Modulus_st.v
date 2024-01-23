/*!>
* Modulus module
*
*+ Input +* 
* 6bit InData 		- Data source
* 4bit InmodulusVal	- modulus value ( Max  decimal 16 )
*
*
*+ Output +* 
*  4bit OutData - Output Data
*
*
<!*/
module Modulus_st(
input [5:0] InData,
input [3:0] InmodulusVal,
output reg [3:0] OutData
);

always @(InData)
	begin
		OutData = InData%InmodulusVal;
	end
endmodule 
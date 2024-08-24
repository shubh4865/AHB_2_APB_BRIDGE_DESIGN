module ahb_slave_interface(input hclk, hresetn, 
                        input hwrite, hreadyin,
                        input [1:0] htrans,
			input [1:0] hresp,
                        input [31:0] haddr, hwdata, prdata,

                        output reg valid,
                        output reg [2:0]tempselx,
                        output reg hwritereg,
			//output reg hwritereg1,
                        output reg [31:0] haddr1, haddr2, hwdata1, hwdata2,
                        output [31:0]hrdata);
//valid logic
always@(*)
    begin
	if (hreadyin && (htrans == 2'b10 || htrans == 2'b11) && haddr >= 32'h8000_0000 && haddr < 32'h8c00_0000)
	  valid = 1'b1;
	else
	  valid = 1'b0;
    end

//Peripheral select logic
always@(*)
    begin
	if(haddr >= 32'h8000_0000 && haddr < 32'h8400_0000)
	tempselx = 3'b001;
	else if(haddr >= 32'h8400_0000 && haddr < 32'h8800_0000)
	tempselx = 3'b010;
	else if(haddr >= 32'h8800_0000 && haddr < 32'h8c00_0000)
	tempselx = 3'b100;
	else
	tempselx = 3'b000;
    end

always@(posedge hclk)
    begin
	if(!hresetn)
	begin
	   haddr1 <= 0;
	   haddr2 <= 0;
	end
	else
 	begin
	   haddr1 <= haddr;
	   haddr2 <= haddr1;
	end
    end

always@(posedge hclk)
    begin
      if(!hresetn)
	begin
	  hwdata1 <= 0;
	  hwdata2 <= 0;
	end
      else
	begin
	  hwdata1 <= hwdata;
	  hwdata2 <= hwdata1;
	end
    end

always@(posedge hclk)
   begin
     if(!hresetn)
	begin
          hwritereg <= 0;
	  //hwritereg1 <= 0;
	end
     else
	begin
          hwritereg <= hwrite;
          //hwritereg1 <= hwritereg;
	end
   end

assign hrdata = prdata;

endmodule

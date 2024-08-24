module bridge_top(input hclk, hresetn, hwrite, hreadyin, 
		  input [1:0]htrans, 
		  input [31:0] haddr, hwdata, prdata, 
		  
	          output pwrite, penable, hreadyout, 
		  output [31:0] pwdata, paddr, hrdata, 
		  output [2:0]pselx 
		  /*output [1:0]hresp*/);

wire [31:0] haddr1, haddr2, hwdata1, hwdata2;
wire [2:0]tempselx;
wire hwritereg; //hwritereg1;
wire valid;

ahb_slave_interface ASI1(.hclk(hclk), 
			.hresetn(hresetn), 
			.hwrite(hwrite), 
			.hreadyin(hreadyin), 
			.htrans(htrans),
			.hresp(hresp), 
			.haddr(haddr), 
			.hwdata(hwdata), 
			.prdata(prdata), 
			.hrdata(hrdata), 
			.valid(valid), 
			.haddr1(haddr1), 
			.haddr2(haddr2), 
			.hwdata1(hwdata1), 
			.hwdata2(hwdata2), 
			.hwritereg(hwritereg), 
			//.hwritereg1(hwritereg1), 
			.tempselx(tempselx));

apb_cont AC2(.hclk(hclk),
			.hresetn(hresetn),
			.valid(valid),
			.haddr(haddr),
			.haddr1(haddr1),
			.haddr2(haddr2),
			.hwdata(hwdata),
			.hwdata1(hwdata1),
			.hwdata2(hwdata2),
			.hwrite(hwrite),
			.hwritereg(hwritereg),
			//.hwritereg1(hwritereg1),
			.tempselx(tempselx),
			.hreadyout(hreadyout), 
			.pwrite(pwrite),
			.penable(penable),
			.pselx(pselx),
			.pwdata(pwdata),
			.paddr(paddr),
			.prdata(prdata));

endmodule

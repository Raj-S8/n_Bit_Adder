module nbitadder_tb;

    localparam WIDTH = 4;

    reg [WIDTH-1:0] A, B;
    reg cin;
    wire [WIDTH-1:0] sum;
    wire cout;

    // Instantiate DUT
    nbitadder #(.WIDTH(WIDTH)) DUT (
        .a(A),
        .b(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $dumpfile("nbitadder_tb.vcd");
        $dumpvars(0, nbitadder_tb);

        // Monitor prints whenever A, B, cin, sum, or cout changes
        $monitor("Time=%0t | A=%b B=%b cin=%b => sum=%b cout=%b",
                  $time, A, B, cin, sum, cout);

        // Test case 1: 0 + 0
        A = 4'b0000; B = 4'b0000; cin = 0; #10;

        // Test case 2: 1 + 1
        A = 4'b0001; B = 4'b0001; cin = 0; #10;

        // Test case 3: Maximum + 1 (overflow check)
        A = 4'b1111; B = 4'b0001; cin = 0; #10;

        // Test case 4: Random mid values
        A = 4'b1010; B = 4'b0101; cin = 0; #10;

        // Test case 5: Both operands max (carry out expected)
        A = 4'b1111; B = 4'b1111; cin = 0; #10;

        // Test case 6: Adding with carry-in = 1
        A = 4'b0011; B = 4'b0101; cin = 1; #10;

        $finish;
    end
endmodule

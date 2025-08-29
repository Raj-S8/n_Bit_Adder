
// Half adder module using data flow modelling

module half_adder(
    input a, b,
    output sum, carry
);

    assign sum = a^b;
    assign carry = a&b;

endmodule

module full_adder(
    input a, b, cin,
    output sum, cout
);
    wire s,c1,c2;

    // ha1 calculates a+b and stores the sum in s and the carry in c1...

    half_adder ha1(.a(a), .b(b), .sum(s), .carry(c1));

    // ha2 then adds the s (sum from ha1) and c1( the carry bit from ha1) and gives us final sum and carry c2..

    half_adder ha2(.a(s), .b(cin), .sum(sum), .carry(c2));

    // now we use gate level modelling to perform an Or operation between c1 and c2 this gives us our final carry cout..

    or(cout, c1, c2);

endmodule

module nbitadder #(parameter WIDTH = 4)(

    input[WIDTH-1:0]a, b,
    input cin,
    output[WIDTH-1:0] sum,
    output cout 

);

    wire [WIDTH:0] carry;

    assign carry[0] = cin;

    genvar i;

    generate
        for( i = 0 ; i < WIDTH; i = i + 1)
        begin : full_adder_gen

            full_adder fa(
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[WIDTH];

endmodule
        
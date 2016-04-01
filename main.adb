with Ada.Real_Time; use Ada.Real_Time;

with STM32F4.GPIO; use STM32F4.GPIO;
with STM32F4; use STM32F4;
with Registers; use Registers;

procedure Main is
   
   procedure Initialize is
      RCC_AHB1ENR_GPIOKGD : constant Word := 16#0448#;
   begin
      --  Enable clock for GPIOK, GPIOG, GPIOD
      RCC.AHB1ENR := RCC.AHB1ENR or RCC_AHB1ENR_GPIOKGD;
      
      --  Configure PD4-5
      GPIOD.MODER   (4 .. 5) := (others => Mode_OUT);
      GPIOD.OTYPER  (4 .. 5) := (others => Type_PP);
      GPIOD.OSPEEDR (4 .. 5) := (others => Speed_100MHz);
      GPIOD.PUPDR   (4 .. 5) := (others => No_Pull);
      --  Configure PG6
      GPIOG.MODER   (6) := Mode_OUT;
      GPIOG.OTYPER  (6) := Type_PP;
      GPIOG.OSPEEDR (6) := Speed_100MHz;
      GPIOG.PUPDR   (6) := No_Pull;
      --  Configure PK3
      GPIOK.MODER   (3) := Mode_OUT;
      GPIOK.OTYPER  (3) := Type_PP;
      GPIOK.OSPEEDR (3) := Speed_100MHz;
      GPIOK.PUPDR   (3) := No_Pull;
   end Initialize;
   
   procedure Green_Off with Inline is
   begin
      GPIOG.BSRR := 16#0000_0040#;
   end Green_Off;
   
   procedure Orange_Off with Inline is
   begin
      GPIOD.BSRR := 16#0000_0010#;
   end Orange_Off;
   
   procedure Red_Off with Inline is
   begin
      GPIOD.BSRR := 16#0000_0020#;
   end Red_Off;
   
   procedure Blue_Off with Inline is
   begin
      GPIOK.BSRR := 16#0000_0008#;
   end Blue_Off;
   
   procedure Green_On with Inline is
   begin
      GPIOG.BSRR := 16#0040_0000#;
   end Green_On;
   
   procedure Orange_On with Inline is
   begin
      GPIOD.BSRR := 16#0010_0000#;
   end Orange_On;
   
   procedure Red_On with Inline is
   begin
      GPIOD.BSRR := 16#0020_0000#;
   end Red_On;
   
   procedure Blue_On with Inline is
   begin
      GPIOK.BSRR := 16#0008_0000#;
   end Blue_On;
      
   procedure All_On is
   begin
      Green_On;
      Orange_On;
      Red_On;
      Blue_On;
   end All_On;
   
   procedure All_Off is
   begin
      Green_Off;
      Orange_Off;
      Red_Off;
      Blue_Off;
   end All_Off;
   
   procedure Up is
   begin
      Green_On; delay until Clock + Milliseconds(400);
      Orange_On; delay until Clock + Milliseconds(300);
      Red_On; delay until Clock + Milliseconds(200);
      Blue_On; delay until Clock + Milliseconds(100);
   end Up;
   
   procedure Down is
   begin
      Blue_Off; delay until Clock + Milliseconds(50);
      Red_Off; delay until Clock + Milliseconds(100); 
      Orange_Off; delay until Clock + Milliseconds(200);
      Green_Off; delay until Clock + Milliseconds(400);
   end Down;
   
begin
   Initialize;
   All_Off;
   for I in 1..3 loop
     All_On;
     delay until Clock + Milliseconds(100);
     All_Off;
     delay until Clock + Milliseconds(100);
   end loop;
   loop
      Up;
      Down;
   end loop;
end Main;

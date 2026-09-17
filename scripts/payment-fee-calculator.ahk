; Ctrl+Alt+W: open a calculator for passing payment-processing fees to a payer.
^!w::ShowPaymentFeeCalculator()

global PaymentFeeCalculatorGui := 0

ShowPaymentFeeCalculator() {
    global PaymentFeeCalculatorGui
    if IsObject(PaymentFeeCalculatorGui) {
        PaymentFeeCalculatorGui.Show()
        return
    }

    clipboardAmount := RegExReplace(Trim(A_Clipboard), "[,$\s]")
    if !RegExMatch(clipboardAmount, "^\d+(\.\d+)?$")
        clipboardAmount := ""

    calculator := Gui("+AlwaysOnTop", "Payment Processing Fee Calculator")
    calculator.SetFont("s10", "Segoe UI")
    calculator.MarginX := 18
    calculator.MarginY := 16

    calculator.AddText("xm", "Amount you need to receive")
    amountEdit := calculator.AddEdit("xm w260", clipboardAmount)
    calculator.AddText("xm y+12", "Percentage fee")
    percentageEdit := calculator.AddEdit("xm w125", "2.9")
    calculator.AddText("x+8 yp+3", "%")
    calculator.AddText("xm y+12", "Fixed fee")
    calculator.AddText("xm y+5", "$")
    fixedEdit := calculator.AddEdit("x+3 yp-3 w105", "0.60")

    calculator.AddText("xm y+18 w260 0x10")
    calculator.AddText("xm y+12", "Fee to add")
    feeResult := calculator.AddText("xm w260", "—")
    feeResult.SetFont("s13 w600")
    calculator.AddText("xm y+10", "Total to charge")
    totalResult := calculator.AddText("xm w260", "—")
    totalResult.SetFont("s13 w600")
    validationText := calculator.AddText("xm y+8 w310", "")

    copyFeeButton := calculator.AddButton("xm y+14 w100 Disabled", "Copy &fee")
    copyTotalButton := calculator.AddButton("x+8 w100 Disabled", "Copy &total")
    calculator.AddButton("x+8 w90", "&Close").OnEvent("Click", (*) => ClosePaymentFeeCalculator())
    feeValue := ""
    totalValue := ""

    Recalculate(*) {
        amountText := RegExReplace(Trim(amountEdit.Value), "[,$\s]")
        percentageText := RegExReplace(Trim(percentageEdit.Value), "[%\s]")
        fixedText := RegExReplace(Trim(fixedEdit.Value), "[,$\s]")
        if !RegExMatch(amountText, "^\d+(\.\d+)?$")
            return ShowInvalid("Enter a valid amount.")
        if !RegExMatch(percentageText, "^\d+(\.\d+)?$")
            return ShowInvalid("Enter a valid percentage fee.")
        if !RegExMatch(fixedText, "^\d+(\.\d+)?$")
            return ShowInvalid("Enter a valid fixed fee.")

        amount := amountText + 0
        percentage := percentageText + 0
        fixedFee := fixedText + 0
        if (percentage >= 100)
            return ShowInvalid("The percentage fee must be less than 100%.")

        rate := percentage / 100
        feeToAdd := (amount * rate + fixedFee) / (1 - rate)
        totalToCharge := amount + feeToAdd
        feeValue := Format("{:.2f}", feeToAdd)
        totalValue := Format("{:.2f}", totalToCharge)
        feeResult.Text := "$" feeValue
        totalResult.Text := "$" totalValue
        validationText.Text := ""
        copyFeeButton.Enabled := true
        copyTotalButton.Enabled := true
    }

    ShowInvalid(message) {
        feeResult.Text := "—"
        totalResult.Text := "—"
        validationText.Text := message
        copyFeeButton.Enabled := false
        copyTotalButton.Enabled := false
    }

    CopyFee(*) {
        A_Clipboard := feeValue
    }
    CopyTotal(*) {
        A_Clipboard := totalValue
    }

    amountEdit.OnEvent("Change", Recalculate)
    percentageEdit.OnEvent("Change", Recalculate)
    fixedEdit.OnEvent("Change", Recalculate)
    copyFeeButton.OnEvent("Click", CopyFee)
    copyTotalButton.OnEvent("Click", CopyTotal)
    calculator.OnEvent("Close", (*) => ClosePaymentFeeCalculator())
    PaymentFeeCalculatorGui := calculator
    Recalculate()
    calculator.Show("AutoSize")
}

ClosePaymentFeeCalculator() {
    global PaymentFeeCalculatorGui
    if IsObject(PaymentFeeCalculatorGui)
        PaymentFeeCalculatorGui.Destroy()
    PaymentFeeCalculatorGui := 0
}

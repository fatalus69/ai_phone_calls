public class AddAITalkTestOption extends ScriptableSystem {
    private let m_phoneSystem: wref<PhoneSystem>;

    protected cb func OnAttach() -> Bool {
        this.m_phoneSystem = GameInstance.GetPhoneSystem();
        this.m_phoneSystem.RegisterCallback(this, n"OnPhoneCallStarted");
    }

    protected cb func OnPhoneCallStarted(call: ref<PhoneCall>) {
        if !call.IsQuestCall() {
            this.AddAITalkTestOption(call);
        }
    }

    private func AddAITalkTestOption(call: ref<PhoneCall>) {
        let option: ref<PhoneCallOption> = new PhoneCallOption();
        option.text = "AI Talk Test";
        option.callback = this.OnAITalkTestSelected;
        call.AddOption(option);
    }

    private cb func OnAITalkTestSelected(option: ref<PhoneCallOption>) {
        GameInstance.GetUISystem().QueueEvent(new ShowMessageEvent("AI Talk Test selected!"));
    }
}
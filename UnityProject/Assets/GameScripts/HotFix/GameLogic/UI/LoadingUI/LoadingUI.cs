using TMPro;
using UnityEngine;
using UnityEngine.UI;
using TEngine;
using System;
using DG.Tweening;

namespace GameLogic
{
    [Window(UILayer.UI, location : "UI_LoadingUI")]
    public partial class LoadingUI : UIWindow
    {
        #region 脚本工具生成的代码

        private UIBindComponent m_bindComponent;
        private Image m_imgBg = null!;
        private Text m_textUpdateDesc = null!;
        private Image m_imgLogo = null!;
        private Image m_progressFill = null!;

        protected override void ScriptGenerator()
        {
            m_bindComponent = gameObject.GetComponent<UIBindComponent>();
            if (m_bindComponent == null)
            {
                Log.Error($"根物体: {gameObject.name} 缺少组件 UIBindComponent, 请检查！！！");
                return;
            }
            m_imgBg = m_bindComponent.GetComponent<Image>(0);
            m_textUpdateDesc = m_bindComponent.GetComponent<Text>(1);
            m_imgLogo = m_bindComponent.GetComponent<Image>(2);
            m_progressFill = m_bindComponent.GetComponent<Image>(3);
        }

        #endregion


        #region 事件
        private void DoLoadAni(float duration = 1f) {
            m_progressFill.DOFillAmount(1, duration).OnComplete(() =>
            {
                LoadEnd();
            });
        }

        private void LoadEnd() {
            Close();
            GameModule.Scene.LoadSceneAsync("MainScene");
            GameModule.UI.ShowUIAsync<MainUI>();
        }
        #endregion

        protected override void OnCreate()
        {
            base.OnCreate();
            m_progressFill.fillAmount = 0;
            DoLoadAni();
        }


        protected override void OnUpdate()
        {
            base.OnUpdate();
            m_textUpdateDesc.text = $"正在加载资源...{m_progressFill.fillAmount*100}%";
        }
    }
}
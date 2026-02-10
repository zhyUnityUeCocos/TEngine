using TMPro;
using UnityEngine;
using UnityEngine.UI;
using TEngine;

namespace GameLogic
{
	[Window(UILayer.UI, location : "UI_MainUI")]
	public partial class MainUI
	{
		#region 事件

		private partial void OnClickGreenBg2Btn()
		{
			Debug.Log("跳转场景");
			GameModule.Scene.LoadSceneAsync("GameScene");
			Close();
		}

		#endregion
	}
}

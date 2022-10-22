﻿#if UNITY_EDITOR

using UnityEngine;
using UnityEditor;

namespace TimeOfDay.Utility
{
    public enum TOD_ShurikenStyle{ TitleHeader, Title, Tab }
    
    public static class TOD_EditorGUIUtility
    {
        #region [Serparator]

        /// <summary> Separator Line. </summary>
        /// <param name="height"> Line Height </param>
        public static void Separator(int height)
        {
            GUILayout.Box("", new GUILayoutOption[]{ GUILayout.ExpandWidth(true), GUILayout.Height(height)});
        }

        public static void Separator(int height, Color color)
        {
            GUI.color = color;
            GUILayout.Box("", new GUILayoutOption[]{ GUILayout.ExpandWidth(true), GUILayout.Height(height)});
            GUI.color = Color.white;
        }

        #endregion

        #region [Label]

        public static void CenterLabel(string tex, GUIStyle style)
        {
          
            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            GUILayout.Label(tex, style);
            GUILayout.FlexibleSpace();
            EditorGUILayout.EndHorizontal();
        }

        public static void CenterLabel(string tex, GUIStyle style, int width)
        {
            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            GUILayout.Label(tex, style, GUILayout.Width(width));
            GUILayout.FlexibleSpace();
            EditorGUILayout.EndHorizontal();
        }

        #endregion

        #region [Header]

        static readonly GUIStyle ShurikenStyleTitleHeader = new GUIStyle("ShurikenModuleTitle")
        {
            font          = new GUIStyle("Label").font,
            border        = new RectOffset(15, 7, 4, 4),
            fixedHeight   = 30,
            contentOffset = new Vector2(20f, -2f)
        };

        static readonly GUIStyle ShurikenStyleTitle = new GUIStyle("ShurikenModuleTitle")
        {
            font          = new GUIStyle("Label").font,
            border        = new RectOffset(15, 7, 4, 4),
            fixedHeight   = 25,
            contentOffset = new Vector2(20f, -2f)
        };

        static readonly GUIStyle ShurikenStyleTab = new GUIStyle("ShurikenModuleTitle")
        {
            font          = new GUIStyle("Label").font,
            border        = new RectOffset(15, 7, 4, 4),
            fixedHeight   = 20,
            contentOffset = new Vector2(20f, -2f)
        };
               
        public static void ShurikenHeader(string tex, GUIStyle texStyle, TOD_ShurikenStyle style)
        {
            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(25));

                break;
            }
            CenterLabel(tex, texStyle);
            EditorGUILayout.EndHorizontal();
        }

        public static void ShurikenHeader(string tex, GUIStyle texStyle, int height, TOD_ShurikenStyle style)
        {
          
            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(height));

                break;
            }
            CenterLabel(tex, texStyle);
            EditorGUILayout.EndHorizontal();
        }

        #endregion

        #region [Foldout|Header]

        public static void ShurikenFoldoutHeader(string text, SerializedProperty foldout, TOD_ShurikenStyle style)
        {

            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(25));

                break;
            }
            foldout.boolValue = GUILayout.Toggle(foldout.boolValue, new GUIContent(text), EditorStyles.foldout, GUILayout.Width(25));
            EditorGUILayout.EndHorizontal();
        }

        public static void ShurikenFoldoutHeader(string text, ref bool foldout, TOD_ShurikenStyle style)
        {

            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(25));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(25));

                break;
            }
            foldout = GUILayout.Toggle(foldout, new GUIContent(text), EditorStyles.foldout, GUILayout.Width(25));
            EditorGUILayout.EndHorizontal();
        }


        public static void ShurikenFoldoutHeader(string text, SerializedProperty foldout, int height, TOD_ShurikenStyle style)
        {

            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(height));

                break;
            }
            foldout.boolValue = GUILayout.Toggle(foldout.boolValue, new GUIContent(text), EditorStyles.foldout, GUILayout.Width(25));
            EditorGUILayout.EndHorizontal();
        }

        public static void ShurikenFoldoutHeader(string text, ref bool foldout, int height, TOD_ShurikenStyle style)
        {

            switch(style)
            {
                case TOD_ShurikenStyle.TitleHeader:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitleHeader, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Title:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTitle, GUILayout.Height(height));

                break;

                case TOD_ShurikenStyle.Tab:

                    EditorGUILayout.BeginHorizontal(ShurikenStyleTab, GUILayout.Height(height));

                break;
            }
            foldout = GUILayout.Toggle(foldout, new GUIContent(text), EditorStyles.foldout, GUILayout.Width(25));
            EditorGUILayout.EndHorizontal();
        }
     
        #endregion
    }
}
#endif
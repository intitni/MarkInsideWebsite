// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

import tailwindcss from '@tailwindcss/vite';

import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  site: "https://markinside.intii.com",
  output: "server",
  server: {
    host: "127.0.0.1",
    port: 4321,
  },
  integrations: [
    starlight({
      title: "MarkInside for macOS and Windows",
      description: "MarkInside for macOS and Windows",
      tagline: "Create, edit and preview rich diagrams from plain text.",
      favicon: "/favicon.png",
      customCss: ["/src/styles/global.css"],
      locales: {
        root: { label: "English", lang: "en" },
        "zh-cn": { label: "中文", lang: "zh-CN" },
      },
      defaultLocale: "root",
      head: [
        {
          tag: "meta",
          attrs: { name: "twitter:site", content: "@intitni" },
        },
        {
          tag: "meta",
          attrs: { name: "twitter:creator", content: "@intitni" },
        },
      ],
      pagefind: false,
      pagination: false,
      credits: false,
      sidebar: [],
      components: {
        Header: "./src/components/Header.astro",
        Footer: "./src/components/Footer.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
        PageTitle: "./src/components/title.astro",
      },
    }),
  ],

  vite: {
    plugins: [tailwindcss()],
    server: {
      host: "127.0.0.1",
      port: 4321,
      strictPort: true,
      hmr: {
        protocol: "ws",
        host: "127.0.0.1",
        port: 4321,
        clientPort: 4321,
      },
    },
  },

  adapter: cloudflare(),
});

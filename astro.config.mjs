// @ts-check
import { defineConfig } from "astro/config"
import starlight from "@astrojs/starlight"
// see https://github.com/withastro/starlight/issues/721
import remarkMath from "remark-math"
import rehypeMathjax from "rehype-mathjax"

import starlightImageZoom from 'starlight-image-zoom'
import starlightThemeRapide from 'starlight-theme-rapide'


// https://astro.build/config
export default defineConfig({
  base: '',
  site: "https://intro.info-mines.paris",
  // for mathjax
  markdown: {
    remarkPlugins: [remarkMath],
    rehypePlugins: [rehypeMathjax],
  },
  integrations: [
    starlight({
      title: "UE12/UE22 - Introduction",
      favicon: "media/favicon-p25.svg",
       logo: {
        light: "/src/media/logo-p25-light.svg",
        dark: "/src/media/logo-p25-dark.svg",
        alt: "MinesParis PSL P25",
      },
      social: {
        github: "https://github.com/ue12-p25/intro",
      },
      plugins: [
        starlightThemeRapide(),
        // for zoomable images
        starlightImageZoom(),
      ],
      customCss: [
        "./src/styles/custom.css",
      ],
      sidebar: [
        {
          label: "Introduction",
          items: [
            { label: "<tl;dr>", slug: "0-1-presentation-ue12-ue22" },
            { label: "Version longue", slug: "0-2-presentation-longue" },
            { label: "Les supports", slug: "0-3-supports" },
          ],
        },
        {
          label: "Installation et configuration",
          items: [
            { label: "Installations", slug: "1-1-installations" },
            { label: "Cloner et lire le cours", slug: "1-2-clone-and-play" },
          ],
        },
        {
          label: "Les outils",
          items: [
            { label: "Le terminal", slug: "2-1-terminal-os" },
            { label: "vs-code & markdown", slug: "2-2-vscode-markdown" },
            { label: "Python", slug: "2-3-python" },
            { label: "Jupyter", slug: "2-4-jupyter" },
            { label: "git(hub)", slug: "2-5-git-optional" },
          ],
        },
        {
          label: "Compléments",
          items: [
            { label: "Checklist", slug: "3-1-checklist" },
            { label: "Troubleshooting", slug: "3-2-troubleshooting" },
            { label: "Environnements virtuels", slug: "3-3-virtual-envs" },
          ],
        },
      ],
    }),
  ],
})

import { defineConfig } from 'vite'
import { resolve } from 'path'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import EnvironmentPlugin from 'vite-plugin-environment'
import FullReload from 'vite-plugin-full-reload'
import RubyPlugin from 'vite-plugin-ruby'
import react from '@vitejs/plugin-react'
import inject from "@rollup/plugin-inject";

export default defineConfig({
  plugins: [
    inject({
      $: 'jquery',
      jQuery: 'jquery',
    }),
    StimulusHMR(),
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 500 }),
    react({
      include: /\.(js|jsx|ts|tsx)$/,
      babel: {
          parserOpts: {
            plugins: ['decorators-legacy'],
          },
        },
    }),    
  ],

  resolve: {
    alias: {
      '@src': resolve(__dirname, 'app/javascript'),
    },
  },
})

// https://vite-ruby.netlify.app/guide/plugins.html

// EnvironmentPlugin https://github.com/ElMassimo/vite-plugin-environment